import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  // Make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Open the database, create if it doesn't exist
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE images (
            id INTEGER PRIMARY KEY,
            fileName TEXT,
            image BLOB
          )
        ''');
    // Create Profile table
    await db.execute('''
          CREATE TABLE Profile (
            id INTEGER PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            objective TEXT,
            address TEXT,
            email TEXT,
            phoneNumber TEXT,
            dateOfBirth TEXT,
            gender TEXT,
            fileName TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVNames (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVObjective (
            id INTEGER PRIMARY KEY,
            objective TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVEducation (
            id INTEGER PRIMARY KEY,
            institute TEXT,
            degree TEXT,
            university TEXT,
            startdate TEXT,
            enddate TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVExperience (
            id INTEGER PRIMARY KEY,
            company TEXT,
            job TEXT,
            details TEXT,
            startdate TEXT,
            enddate TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVSkills (
            id INTEGER PRIMARY KEY,
            skill TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVInterests (
            id INTEGER PRIMARY KEY,
            interest TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVAchievements (
            id INTEGER PRIMARY KEY,
            achievement TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVLanguages (
            id INTEGER PRIMARY KEY,
            language TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVReferences (
            id INTEGER PRIMARY KEY,
            reference TEXT,
            job TEXT,
            company TEXT,
            email TEXT,
            phoneNumber TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVProjects (
            id INTEGER PRIMARY KEY,
            project TEXT,
            fileName TEXT
          )
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS CVSocialLinks (
            id INTEGER PRIMARY KEY,
            fblink TEXT,
            linkedinlink TEXT,
            twitterlink TEXT,
            instalink TEXT,
            fileName TEXT
          )
        ''');
    // Create other tables here as needed
  }

  Future<int> insertImage(String fileName, File imageFile) async {
    final db = await database;
    final bytes = await imageFile.readAsBytes();
    return await db.insert('images', {'fileName': fileName, 'image': bytes});
  }

  Future<int> insertOrUpdateImage(String fileName, File newImage) async {
    final db = await database;
    final existingImage = await getImageByFileName(fileName);
    if (existingImage != null) {
      // If an image with the same fileName exists, update it
      return await updateImageByFileName(fileName, newImage);
    } else {
      // If no image with the same fileName exists, insert it
      return await insertImage(fileName, newImage);
    }
  }

  Future<File?> getImageByFileName(String fileName) async {
    final db = await database;
    final result = await db.query(
      'images',
      where: 'fileName = ?',
      whereArgs: [fileName],
    );
    if (result.isNotEmpty) {
      final imageBytes = result.first['image'] as Uint8List;
      final image =
          File('${(await getTemporaryDirectory()).path}/$fileName.jpg');
      await image.writeAsBytes(imageBytes);
      return image;
    }
    return null;
  }

  Future<int> deleteImageByFileName(String fileName) async {
    final db = await database;
    return await db.delete(
      'images',
      where: 'fileName = ?',
      whereArgs: [fileName],
    );
  }

  Future<int> updateImageByFileName(String fileName, File newImage) async {
    final db = await database;
    final bytes = await newImage.readAsBytes();
    return await db.update(
      'images',
      {'image': bytes},
      where: 'fileName = ?',
      whereArgs: [fileName],
    );
  }

  // Profile Table Functions Starting

  // Insert a row into the Profile table
  Future<String> insertProfile(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    List<Map<String, dynamic>> matchingRows =
        await db.query('Profile', where: 'fileName = ?', whereArgs: [fileName]);
    if (matchingRows.isNotEmpty) {
      await updateProfile(row, fileName);
      return 'Updated Successfully';
    } else {
      await db.insert('Profile', row);
      return 'Profile saved successfully!';
    }
  }

  // Query rows from the Profile table where fileName is the same
  Future<List<Map<String, dynamic>>> queryProfileRowByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('Profile', where: 'fileName = ?', whereArgs: [fileName]);
  }

  // Update a row in the Profile table based on fileName
  Future<String> updateProfile(
      Map<String, dynamic> row, String fileName) async {
    Database db = await instance.database;
    await db.update(
      'Profile',
      row,
      where: 'fileName = ?',
      whereArgs: [fileName],
    );
    return 'Updated';
  }

  // Delete a row from the Profile table
  Future<int> deleteProfile(String fileName) async {
    Database db = await instance.database;
    return await db
        .delete('Profile', where: 'fileName = ?', whereArgs: [fileName]);
  }

  // Profile Table Functions Ended

  // CVNames Table Functions Starting

  static Future<bool> checkNameExists(String name) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'CVNames',
      where: 'name = ?',
      whereArgs: [name],
    );

    return maps.isNotEmpty;
  }

  static Future<String> insertName(String name) async {
    final Database db = await instance.database;

    List<Map<String, dynamic>> matchingRows =
        await db.query('CVNames', where: 'name = ?', whereArgs: [name]);
    if (matchingRows.isNotEmpty) {
      return 'File Name Already Present';
    }

    await db.insert(
      'CVNames',
      {
        'name': name,
      },
    );

    return 'File Name Added Successfully';
  }

  Future<List<Map<String, dynamic>>> queryAllNameRows() async {
    Database db = await instance.database;
    return await db.query('CVNames');
  }

  Future<String> deleteName(String fileName) async {
    Database db = await instance.database;
    await db.delete('CVNames', where: 'fileName = ?', whereArgs: [fileName]);
    return 'Deleted Successfully';
  }

  // CVNames Table Functions Ended

  // CVObjectives Table Functions Starting

  Future<String> insertObjective(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    List<Map<String, dynamic>> matchingRows = await db
        .query('CVObjective', where: 'fileName = ?', whereArgs: [fileName]);
    if (matchingRows.isNotEmpty) {
      await updateObjective(row, fileName);
      return 'Objective Updated Successfully';
    } else {
      await db.insert('CVObjective', row);
      return 'Objective saved successfully!';
    }
  }

  Future<String> updateObjective(
      Map<String, dynamic> row, String fileName) async {
    Database db = await instance.database;
    await db.update(
      'CVObjective',
      row,
      where: 'fileName = ?',
      whereArgs: [fileName],
    );
    return 'Updated';
  }

  Future<List<Map<String, dynamic>>> queryObjectiveRowByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVObjective', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteObjective(String fileName) async {
    Database db = await instance.database;
    await db
        .delete('CVObjective', where: 'fileName = ?', whereArgs: [fileName]);
    return 'Deleted Successfully';
  }

  // CVObjectives Table Functions Ended

  // CVSocialLinks Table Functions Starting

  Future<String> insertSocialLinks(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    List<Map<String, dynamic>> matchingRows = await db
        .query('CVSocialLinks', where: 'fileName = ?', whereArgs: [fileName]);
    if (matchingRows.isNotEmpty) {
      await updateSocialLinks(row, fileName);
      return 'SocialLinks Updated Successfully';
    } else {
      await db.insert('CVSocialLinks', row);
      return 'SocialLinks saved successfully!';
    }
  }

  Future<String> updateSocialLinks(
      Map<String, dynamic> row, String fileName) async {
    Database db = await instance.database;
    await db.update(
      'CVSocialLinks',
      row,
      where: 'fileName = ?',
      whereArgs: [fileName],
    );
    return 'Updated';
  }

  Future<List<Map<String, dynamic>>> querySocialLinksRowByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVSocialLinks', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteSocialLinks(String fileName) async {
    Database db = await instance.database;
    await db
        .delete('CVSocialLinks', where: 'fileName = ?', whereArgs: [fileName]);
    return 'Deleted Successfully';
  }

  // CVSocialLinks Table Functions Ended

  // CVEducation Table Functions Starting

  Future<String> insertEducation(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    int ids = row['id'];
    // Count the number of rows with the same fileName
    int rowCount = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT(*) FROM CVEducation WHERE fileName = ?',
          [fileName],
        )) ??
        0;

    List<Map<String, dynamic>> matchingRows = await db.query('CVEducation',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, ids]);
    if (matchingRows.isNotEmpty) {
      await updateEducation(row, fileName, ids);
      return 'Education Updated Successfully';
    } else {
      if (rowCount >= 3) {
        return 'Education limit exceeds';
      } else {
        await db.insert('CVEducation', row);
        return 'Education saved successfully!';
      }
    }
  }

  Future<String> updateEducation(
      Map<String, dynamic> row, String fileName, int ids) async {
    Database db = await instance.database;
    await db.update(
      'CVEducation',
      row,
      where: 'fileName = ? AND id = ?', // Added 'AND institute = ?'
      whereArgs: [fileName, ids], // Added row['institute']
    );
    return 'Updated';
  }

  Future<List<Map<String, dynamic>>> queryEducationRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVEducation', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<List<Map<String, dynamic>>> queryEducationRowByFileNameAndInstitute(
      String fileName, int ids) async {
    Database db = await instance.database;
    return await db.query('CVEducation',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, ids]);
  }

  Future<String> deleteEducation(String fileName, int ids) async {
    Database db = await instance.database;
    await db.delete('CVEducation',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, ids]);
    await db
        .execute('UPDATE `CVEducation` SET id = id - 1 WHERE id > ?', [ids]);
    return 'Deleted Successfully';
  }

  Future<int> getEducationCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM CVEducation');
    int? count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  // CVEducation Table Functions Ended

  // CVExperience Table Functions Starting

  Future<String> insertExperience(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    int id = row['id'];

    // Count the number of rows with the same fileName
    int rowCount = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT(*) FROM CVExperience WHERE fileName = ?',
          [fileName],
        )) ??
        0;

    List<Map<String, dynamic>> matchingRows = await db.query('CVExperience',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, id]);
    if (matchingRows.isNotEmpty) {
      await updateExperience(row, fileName, id);
      return 'Experience Updated Successfully';
    } else {
      if (rowCount >= 3) {
        return 'Experience limit exceeds';
      } else {
        await db.insert('CVExperience', row);
        return 'Experience saved successfully!';
      }
    }
  }

  Future<String> updateExperience(
      Map<String, dynamic> row, String fileName, int id) async {
    Database db = await instance.database;
    await db.update(
      'CVExperience',
      row,
      where: 'fileName = ? AND id = ?', // Added 'AND institute = ?'
      whereArgs: [fileName, id], // Added row['institute']
    );
    return 'Updated';
  }

  Future<List<Map<String, dynamic>>> queryExperienceRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVExperience', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<List<Map<String, dynamic>>> queryExperienceRowByFileNameAndInstitute(
      String fileName, int id) async {
    Database db = await instance.database;
    return await db.query('CVExperience',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, id]);
  }

  Future<String> deleteExperience(String fileName, int id) async {
    Database db = await instance.database;
    await db.delete('CVExperience',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, id]);
    await db
        .execute('UPDATE `CVExperience` SET id = id - 1 WHERE id > ?', [id]);
    return 'Deleted Successfully';
  }

  Future<int> getExperienceCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM CVExperience');
    int? count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  // CVExperience Table Functions Ended

  // CVReferences Table Functions Starting

  Future<String> insertReference(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // Check if fileName is already present
    String fileName = row['fileName'];
    int id = row['id'];
    List<Map<String, dynamic>> matchingRows = await db.query('CVReferences',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, id]);
    if (matchingRows.isNotEmpty) {
      await updateReference(row, fileName, id);
      return 'References Updated Successfully';
    } else {
      await db.insert('CVReferences', row);
      return 'References saved successfully!';
    }
  }

  Future<String> updateReference(
      Map<String, dynamic> row, String fileName, int id) async {
    Database db = await instance.database;
    await db.update(
      'CVReferences',
      row,
      where: 'fileName = ? AND id = ?', // Added 'AND institute = ?'
      whereArgs: [fileName, id], // Added row['institute']
    );
    return 'Updated';
  }

  Future<List<Map<String, dynamic>>> queryReferenceRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVReferences', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<List<Map<String, dynamic>>> queryReferenceRowByFileNameAndid(
      String fileName, int id) async {
    Database db = await instance.database;
    return await db.query('CVReferences',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, id]);
  }

  Future<String> deleteReference(String fileName, int id) async {
    Database db = await instance.database;
    await db.delete('CVReferences',
        where: 'fileName = ? AND id = ?', whereArgs: [fileName, id]);
    await db
        .execute('UPDATE `CVReferences` SET id = id - 1 WHERE id > ?', [id]);
    return 'Deleted Successfully';
  }

  // CVReferences Table Functions Ended

  // CVSkills Table Functions Starting

  Future<String> insertSkills(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    String skill = row['skill'];
    List<Map<String, dynamic>> matchingRows = await db.query('CVSkills',
        where: 'fileName = ? AND skill = ?', whereArgs: [fileName, skill]);
    if (matchingRows.isNotEmpty) {
      return 'Skill Already Present';
    } else {
      await db.insert('CVSkills', row);
      return 'Skill saved successfully!';
    }
  }

  Future<List<Map<String, dynamic>>> querySkillsRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVSkills', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteSkills(String fileName, String skill) async {
    Database db = await instance.database;
    await db.delete('CVSkills',
        where: 'fileName = ? AND skill = ?', whereArgs: [fileName, skill]);
    return 'Deleted Successfully';
  }

  // CVSkills Table Functions Ended

  // CVInterest Table Functions Starting

  Future<String> insertInterest(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    String interest = row['interest'];
    List<Map<String, dynamic>> matchingRows = await db.query('CVInterests',
        where: 'fileName = ? AND interest = ?',
        whereArgs: [fileName, interest]);
    if (matchingRows.isNotEmpty) {
      return 'Interest Already Present';
    } else {
      await db.insert('CVInterests', row);
      return 'Interest saved successfully!';
    }
  }

  Future<List<Map<String, dynamic>>> queryInterestsRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVInterests', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteInterests(String fileName, String interest) async {
    Database db = await instance.database;
    await db.delete('CVInterests',
        where: 'fileName = ? AND interest = ?',
        whereArgs: [fileName, interest]);
    return 'Deleted Successfully';
  }

  // CVInterest Table Functions Ended

  // CVAchievement Table Functions Starting

  Future<String> insertAchievement(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    String achievement = row['achievement'];
    List<Map<String, dynamic>> matchingRows = await db.query('CVAchievements',
        where: 'fileName = ? AND achievement = ?',
        whereArgs: [fileName, achievement]);
    if (matchingRows.isNotEmpty) {
      return 'Achievement Already Present';
    } else {
      await db.insert('CVAchievements', row);
      return 'Achievement saved successfully!';
    }
  }

  Future<List<Map<String, dynamic>>> queryAchievementsRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVAchievements', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteAchievements(String fileName, String achievement) async {
    Database db = await instance.database;
    await db.delete('CVAchievements',
        where: 'fileName = ? AND achievement = ?',
        whereArgs: [fileName, achievement]);
    return 'Deleted Successfully';
  }

  // CVAchievement Table Functions Ended

  // CVLanguages Table Functions Starting

  Future<String> insertLanguages(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    String language = row['language'];
    List<Map<String, dynamic>> matchingRows = await db.query('CVLanguages',
        where: 'fileName = ? AND language = ?',
        whereArgs: [fileName, language]);
    if (matchingRows.isNotEmpty) {
      return 'Language Already Present';
    } else {
      await db.insert('CVLanguages', row);
      return 'Language saved successfully!';
    }
  }

  Future<List<Map<String, dynamic>>> queryLanguagesRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVLanguages', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteLanguages(String fileName, String language) async {
    Database db = await instance.database;
    await db.delete('CVLanguages',
        where: 'fileName = ? AND language = ?',
        whereArgs: [fileName, language]);
    return 'Deleted Successfully';
  }

  // CVLanguages Table Functions Ended

  // CVProjects Table Functions Starting

  Future<String> insertProjects(Map<String, dynamic> row) async {
    Database db = await instance.database;

    // Check if fileName is already present
    String fileName = row['fileName'];
    String project = row['project'];
    List<Map<String, dynamic>> matchingRows = await db.query('CVProjects',
        where: 'fileName = ? AND project = ?', whereArgs: [fileName, project]);
    if (matchingRows.isNotEmpty) {
      return 'Project Already Present';
    } else {
      await db.insert('CVProjects', row);
      return 'Project saved successfully!';
    }
  }

  Future<List<Map<String, dynamic>>> queryProjectsRowsByFileName(
      String fileName) async {
    Database db = await instance.database;
    return await db
        .query('CVProjects', where: 'fileName = ?', whereArgs: [fileName]);
  }

  Future<String> deleteProjects(String fileName, String project) async {
    Database db = await instance.database;
    await db.delete('CVProjects',
        where: 'fileName = ? AND project = ?', whereArgs: [fileName, project]);
    return 'Deleted Successfully';
  }

// CVProjects Table Functions Ended
}
