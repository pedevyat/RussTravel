import databases

# берем параметры БД из переменных окружения
DB_USER = "russtravel"
DB_PASSWORD = "russtravel"
DB_HOST = "localhost"
DB_NAME = "russtravel"
SQLALCHEMY_DATABASE_URL = (
    f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:5432/{DB_NAME}"
)
# создаем объект database, который будет использоваться для выполнения запросов
database = databases.Database(SQLALCHEMY_DATABASE_URL)