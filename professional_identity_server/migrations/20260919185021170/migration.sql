BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "contact_inquiry" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "senderName" text NOT NULL,
    "senderEmail" text NOT NULL,
    "subject" text NOT NULL,
    "message" text NOT NULL,
    "inquiryType" text NOT NULL DEFAULT 'general'::text,
    "isRead" boolean NOT NULL DEFAULT false,
    "isArchived" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "contact_inquiry_profile_idx" ON "contact_inquiry" USING btree ("profileId");
CREATE INDEX "contact_inquiry_profile_status_idx" ON "contact_inquiry" USING btree ("profileId", "isRead", "isArchived");
CREATE INDEX "contact_inquiry_created_idx" ON "contact_inquiry" USING btree ("profileId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "contact_inquiry"
    ADD CONSTRAINT "contact_inquiry_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR professional_identity
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('professional_identity', '20260919185021170', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919185021170', "timestamp" = now();

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
