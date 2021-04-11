storage = {
  archive2 = "sql";
}

sql = { 
    driver = "PostgreSQL"; 
    database = "{{POSTGRESQL_DATABASE}}"; 
    username = "{{PROSODY_USERNAME}}"; 
    password = "{{PROSODY_PASSWORD}}";
}

