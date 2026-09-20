BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "profile_customization" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "themePreset" text NOT NULL DEFAULT 'minimal'::text,
    "primaryColor" text,
    "backgroundStyle" text NOT NULL DEFAULT 'solid'::text,
    "cardStyle" text NOT NULL DEFAULT 'outlined'::text,
    "borderRadius" text NOT NULL DEFAULT 'medium'::text,
    "typographyStyle" text NOT NULL DEFAULT 'modern'::text,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "profile_customization_profile_idx" ON "profile_customization" USING btree ("profileId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "profile_customization"
    ADD CONSTRAINT "profile_customization_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR professional_identity
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('professional_identity', '20260919152821579-add-profile-customization', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919152821579-add-profile-customization', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
