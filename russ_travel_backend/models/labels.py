import sqlalchemy

metadata = sqlalchemy.MetaData()


museums = sqlalchemy.Table(
    "museums",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
    sqlalchemy.Column("pictureURL", sqlalchemy.String(100)),
    sqlalchemy.Column("latitude", sqlalchemy.Double),
    sqlalchemy.Column("longitude", sqlalchemy.Double),
)

parks = sqlalchemy.Table(
    "parks",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
    sqlalchemy.Column("pictureURL", sqlalchemy.String(100)),
    sqlalchemy.Column("latitude", sqlalchemy.Double),
    sqlalchemy.Column("longitude", sqlalchemy.Double),
)

out_places = sqlalchemy.Table(
    "out_places",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
    sqlalchemy.Column("pictureURL", sqlalchemy.String(100)),
    sqlalchemy.Column("latitude", sqlalchemy.Double),
    sqlalchemy.Column("longitude", sqlalchemy.Double),
)

hotels = sqlalchemy.Table(
    "hotels",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
    sqlalchemy.Column("pictureURL", sqlalchemy.String(100)),
    sqlalchemy.Column("latitude", sqlalchemy.Double),
    sqlalchemy.Column("longitude", sqlalchemy.Double),
)
