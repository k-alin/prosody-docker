storage = {
  archive2 = "sql";
}

sql = { 
    driver = "PostgreSQL"; 
    database = "{{POSTGRESQL_DATABASE}}"; 
    username = "{{POSTGRESQL_USERNAME}}"; 
    password = "{{POSTGRESQL_PASSWORD}}";
}

