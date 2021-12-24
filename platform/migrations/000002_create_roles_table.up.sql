CREATE TABLE roles(
    id UUID DEFAULT uuid_generate_v4 () PRIMARY KEY,
    name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW (),
    deleted_at TIMESTAMP NULL
);

