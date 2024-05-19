import databases

# берем параметры БД из переменных окружения
DB_USER = "russtravel"
DB_PASSWORD = "CTXnKRp6iwUOMmQf6k33dGta2qFQNNk7"
DB_HOST = "dpg-coilasljm4es739qdp8g-a"
DB_NAME = "russtravel"
SQLALCHEMY_DATABASE_URL = (
    #f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:5432/{DB_NAME}"
    #"postgresql://russtravel:russtravel@localhost:5432/russtravel"
    #"postgres://russtravel:CTXnKRp6iwUOMmQf6k33dGta2qFQNNk7@dpg-coilasljm4es739qdp8g-a/russtravel"
    #'postgresql://russtravel:CTXnKRp6iwUOMmQf6k33dGta2qFQNNk7@dpg-coilasljm4es739qdp8g-a:5432/russtravel'
    'postgresql://russtravel:CTXnKRp6iwUOMmQf6k33dGta2qFQNNk7@dpg-coilasljm4es739qdp8g-a.frankfurt-postgres.render.com:5432/russtravel'
)
# создаем объект database, который будет использоваться для выполнения запросов
database = databases.Database(SQLALCHEMY_DATABASE_URL)
