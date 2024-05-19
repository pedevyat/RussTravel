import sqlalchemy

metadata = sqlalchemy.MetaData()


museums = sqlalchemy.Table(
    "museums",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer),
    sqlalchemy.Column("user_id", sqlalchemy.Integer),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
)

parks = sqlalchemy.Table(
    "parks",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer),
    sqlalchemy.Column("user_id", sqlalchemy.Integer),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
)

out_places = sqlalchemy.Table(
    "out_places",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer),
    sqlalchemy.Column("user_id", sqlalchemy.Integer),
    sqlalchemy.Column("title", sqlalchemy.String(100)),
    #sqlalchemy.Column("pictureURL", sqlalchemy.String(100)),
)
