CREATE TABLE radsafety.duration_unit (
  duration_unit_id         INTEGER AUTO_INCREMENT,
  duration_description     VARCHAR(10) NOT NULL,
  duration_in_seconds      DOUBLE       NOT NULL,
  PRIMARY KEY (duration_unit_id)
);

CREATE TABLE radsafety.radioActivityUnit (
  unit_id INTEGER AUTO_INCREMENT,
  unit_name VARCHAR(10) NOT NULL,
  PRIMARY KEY (unit_id)
);


CREATE TABLE radsafety.physical_form (
  physical_form_id              INTEGER AUTO_INCREMENT,
  physical_form_description     VARCHAR(50) NOT NULL,
  PRIMARY KEY (physical_form_id)
);


CREATE TABLE radsafety.agreement (
  agreement_id       INTEGER AUTO_INCREMENT,
  created_date       TIMESTAMP     NOT NULL,
  last_modified_date TIMESTAMP     NOT NULL,
  agreement_text     VARCHAR(2000) NOT NULL,
  agreement_type     VARCHAR(25)   NOT NULL,
  created_by         INTEGER       NOT NULL,
  last_modified_by   INTEGER       NOT NULL,
  campus_code        VARCHAR(2)    NOT NULL,
  PRIMARY KEY (agreement_id)
);

CREATE TABLE radsafety.attachment (
  attachment_id   INTEGER AUTO_INCREMENT,
  attachment_type VARCHAR(25)  NOT NULL,
  content         MEDIUMBLOB,
  content_type    VARCHAR(100) NOT NULL,
  fileName        VARCHAR(255) NOT NULL,
  PRIMARY KEY (attachment_id)
);

CREATE TABLE radsafety.campus (
  id        INTEGER AUTO_INCREMENT,
  code      VARCHAR(2)   NOT NULL,
  name      VARCHAR(100) NOT NULL,
  name_abbr VARCHAR(15)  NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.comment (
  comment_id         INTEGER AUTO_INCREMENT,
  comment_text       VARCHAR(1000),
  review_date        TIMESTAMP NOT NULL,
  reviewer_person_id INTEGER NOT NULL,
  ua_id              INTEGER NOT NULL,
  PRIMARY KEY (comment_id)
);

CREATE TABLE radsafety.core_bundle (
  id           INTEGER AUTO_INCREMENT,
  cs_id        VARCHAR(50)  NOT NULL,
  name         VARCHAR(100) NOT NULL,
  pi_person_id INTEGER      NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.core_bundle_location (
  id             INTEGER AUTO_INCREMENT,
  core_bundle_id INTEGER NOT NULL,
  location_id    INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.core_bundle_person (
  id             INTEGER AUTO_INCREMENT,
  core_bundle_id INTEGER NOT NULL,
  person_id      INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.core_bundle_person_role (
  id                    INTEGER AUTO_INCREMENT,
  role_type             VARCHAR(25) NOT NULL,
  core_bundle_person_id INTEGER     NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.line_number_radionuclide_form (
  line_number_radionuclide_form_id     INTEGER AUTO_INCREMENT,
  line_number_radionuclide_form        VARCHAR(100) NOT NULL,
  PRIMARY KEY (line_number_radionuclide_form_id)
);

CREATE TABLE radsafety.license_type (
  license_type_id     INTEGER AUTO_INCREMENT,
  license_type   VARCHAR(100) NOT NULL,
  PRIMARY KEY (license_type_id)
);

CREATE TABLE radsafety.license_rule_type (
  license_rule_type_id     INTEGER AUTO_INCREMENT,
  license_rule_type   VARCHAR(100) NOT NULL,
  PRIMARY KEY (license_rule_type_id)
);

CREATE TABLE radsafety.license (
  license_id     INTEGER AUTO_INCREMENT,
  license_name   VARCHAR(100) NOT NULL,
  license_number VARCHAR(100) NOT NULL,
  license_amendment_number VARCHAR(100),
  licensee VARCHAR(1000),
  address1         VARCHAR(200),
  address2         VARCHAR(200),
  city             VARCHAR(100),
  state            VARCHAR(2),
  zip              VARCHAR(5),
  expiration_date         DATETIME,
  inspection_agency VARCHAR(100),
  person_id    INTEGER,
  campus_code    VARCHAR(2),
  license_type_id    INTEGER NOT NULL,
  license_rule_type_id    INTEGER NOT NULL,
  PRIMARY KEY (license_id)
);

CREATE TABLE radsafety.license_line_number (
  license_line_number_id     INTEGER AUTO_INCREMENT,
  line_number VARCHAR(100) NOT NULL,
  license_id INTEGER,
  is_specific BOOLEAN NOT NULL,
  license_line_number_info_id INTEGER,
  PRIMARY KEY (license_line_number_id)
);

CREATE TABLE radsafety.license_line_number_info (
  license_line_number_info_id     INTEGER AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(100),
  line_number_radionuclide_form_id INTEGER NOT NULL,
  possession_limit DOUBLE NOT NULL,
  possession_limit_unit_id INTEGER NOT NULL,
  PRIMARY KEY (license_line_number_info_id)
);

--CREATE TABLE radsafety.license_radionuclide (
--  license_radionuclide_id  INTEGER AUTO_INCREMENT,
--  is_sealed_source         BOOLEAN      NOT NULL,
--  license_line_number_id              INTEGER NOT NULL,
--  license_id               INTEGER      NOT NULL,
--  radionuclide_id          INTEGER      NOT NULL,
-- PRIMARY KEY (license_radionuclide_id)
--);

CREATE TABLE radsafety.location (
  id                    INTEGER AUTO_INCREMENT,
  building_display_name VARCHAR(255),
  building_key          VARCHAR(255),
  building_primary_name VARCHAR(255),
  campus_code           VARCHAR(255),
  floor_key             VARCHAR(255),
  floor_name            VARCHAR(255),
  room_key              VARCHAR(255),
  room_number           VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.person (
  id          INTEGER AUTO_INCREMENT,
  department  VARCHAR(100),
  dob         DATETIME,
  email       VARCHAR(100),
  eppn        VARCHAR(50) NOT NULL,
  first_name  VARCHAR(50) NOT NULL,
  gender      VARCHAR(255),
  last_name   VARCHAR(50) NOT NULL,
  net_id      VARCHAR(20),
  phone       VARCHAR(100),
  status      VARCHAR(255),
  campus_code VARCHAR(2)  NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.person_dosimetry (
  id        INTEGER AUTO_INCREMENT,
  address1            VARCHAR(200) NOT NULL,
  address2            VARCHAR(200),
  city                VARCHAR(100) NOT NULL,
  end_date            DATETIME    NOT NULL,
  institution_name    VARCHAR(200) NOT NULL,
  start_date          DATETIME    NOT NULL,
  state               VARCHAR(2)   NOT NULL,
  zip                 VARCHAR(5)   NOT NULL,
  person_id           INTEGER      NOT NULL,
  created_from        INTEGER,
  is_active           BOOLEAN      NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.person_experience (
  id               INTEGER AUTO_INCREMENT,
  address1         VARCHAR(200)  NOT NULL,
  address2         VARCHAR(200),
  city             VARCHAR(100)  NOT NULL,
  end_date         DATETIME     NOT NULL,
  institution_name VARCHAR(200)  NOT NULL,
  start_date       DATETIME     NOT NULL,
  state            VARCHAR(2)    NOT NULL,
  type_of_work     VARCHAR(1000) NOT NULL,
  zip              VARCHAR(5)    NOT NULL,
  person_id        INTEGER       NOT NULL,
  created_from     INTEGER,
  is_active        BOOLEAN       NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.person_role (
  person_role_id INTEGER AUTO_INCREMENT,
  role_type      VARCHAR(100) NOT NULL,
  created_date       TIMESTAMP     NOT NULL,
  last_modified_date TIMESTAMP     NOT NULL,
  created_by         INTEGER       NOT NULL,
  last_modified_by   INTEGER       NOT NULL,
  person_id      INTEGER      NOT NULL,
  PRIMARY KEY (person_role_id)
);

CREATE TABLE radsafety.person_training (
  id               INTEGER AUTO_INCREMENT,
  completed_date   DATETIME,
  expiry_date      DATETIME,
  duration         DOUBLE,
  institution_name VARCHAR(200),
  topic            VARCHAR(200) NOT NULL,
  lms_id           DOUBLE,
  person_id        INTEGER      NOT NULL,
  created_from     INTEGER,
  is_active        BOOLEAN      NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.radionuclide (
  radionuclide_id             INTEGER AUTO_INCREMENT,
  name                        VARCHAR(50)   NOT NULL,
  half_life                   DOUBLE        NOT NULL,
  half_life_unit              INTEGER       NOT NULL,
  radiotoxicity               DOUBLE        NOT NULL,
  z_value                     INTEGER       NOT NULL,
  is_alpha_emitter            BOOLEAN       NOT NULL,
  is_beta_emitter             BOOLEAN       NOT NULL,
  is_gamma_emitter            BOOLEAN       NOT NULL,
  is_neutron_emitter          BOOLEAN       NOT NULL,
  is_source_material          BOOLEAN       NOT NULL,
  is_special_nuclear_material BOOLEAN       NOT NULL,
  PRIMARY KEY (radionuclide_id)
);

CREATE TABLE radsafety.soe (
  id                    INTEGER AUTO_INCREMENT,
  last_step_completed   INTEGER     NOT NULL,
  status_type           VARCHAR(25) NOT NULL,
  ua_id                 INTEGER     NOT NULL,
  person_id             INTEGER     NOT NULL,
  created_from          INTEGER,
  is_active             BOOLEAN       NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.ua_pw_attachment (
  ua_pw_id            INTEGER NOT NULL,
  attachment_id                       INTEGER NOT NULL,
  PRIMARY KEY (ua_pw_id, attachment_id)
);

CREATE TABLE radsafety.soe_person_experience (
  person_experience_id  INTEGER NOT NULL,
  soe_id                INTEGER NOT NULL,
  PRIMARY KEY (person_experience_id, soe_id)
);

CREATE TABLE radsafety.soe_person_dosimetry (
  person_dosimetry_id  INTEGER NOT NULL,
  soe_id               INTEGER NOT NULL,
  PRIMARY KEY (person_dosimetry_id, soe_id)
);

CREATE TABLE radsafety.soe_person_training (
  person_training_id  INTEGER NOT NULL,
  soe_id              INTEGER NOT NULL,
  PRIMARY KEY (person_training_id, soe_id)
);

CREATE TABLE radsafety.training_attachment (
  person_training_id INTEGER NOT NULL,
  attachment_id      INTEGER NOT NULL,
  PRIMARY KEY (person_training_id, attachment_id)
);

CREATE TABLE radsafety.ua (
  id                 INTEGER AUTO_INCREMENT,
  created_date       TIMESTAMP   NOT NULL,
  last_modified_date TIMESTAMP   NOT NULL,
  number             INTEGER,
  status_type        VARCHAR(25) NOT NULL,
  type               VARCHAR(25) NOT NULL,
  expiry_date        DATETIME   NOT NULL,
  created_by         INTEGER     NOT NULL,
  last_modified_by   INTEGER     NOT NULL,
  pi_person_id       INTEGER     NOT NULL,
  created_from       INTEGER,
  is_active          BOOLEAN      NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.amendment (
  amendment_id                 INTEGER AUTO_INCREMENT,
  ua_id              INTEGER,
  amendment_number   INTEGER     NOT NULL,
  created_date       TIMESTAMP   NOT NULL,
  last_modified_date TIMESTAMP   NOT NULL,
  created_by         INTEGER     NOT NULL,
  last_modified_by   INTEGER     NOT NULL,
  PRIMARY KEY (amendment_id)
);

CREATE TABLE radsafety.amendment_item (
  amendment_item_id                 INTEGER AUTO_INCREMENT,
  table_name         VARCHAR(100),
  column_name        VARCHAR(100),
  column_id          INTEGER,
  old_value          VARCHAR(3000),
  new_value          VARCHAR(3000),
  amendment_id       INTEGER,
  created_date       TIMESTAMP   NOT NULL,
  last_modified_date TIMESTAMP   NOT NULL,
  created_by         INTEGER     NOT NULL,
  last_modified_by   INTEGER     NOT NULL,
  PRIMARY KEY (amendment_item_id)
);

CREATE TABLE radsafety.ua_bundle (
  id    INTEGER AUTO_INCREMENT,
  cs_id VARCHAR(255),
  name  VARCHAR(255),
  ua_id INTEGER,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.ua_bundle_location (
  id           INTEGER AUTO_INCREMENT,
  sub_location VARCHAR(255),
  location_id  INTEGER NOT NULL,
  ua_bundle_id INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.ua_bundle_person (
  id           INTEGER AUTO_INCREMENT,
  person_id    INTEGER NOT NULL,
  ua_bundle_id INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE radsafety.ua_bundle_attachment (
  ua_bundle_id       INTEGER NOT NULL,
  attachment_id      INTEGER NOT NULL,
  PRIMARY KEY (ua_bundle_id, attachment_id)
);

CREATE TABLE radsafety.ua_planned_work (
  ua_pw_id                         INTEGER AUTO_INCREMENT,
  chemical_form                    VARCHAR(50)   NOT NULL,
  description_of_use               VARCHAR(3000),
  potential_hazards                VARCHAR(3000),
  protection_precautions           VARCHAR(3000),
  waste_methods                    VARCHAR(3000),
  experiment_possession_limit_mci  DOUBLE        NOT NULL,
  is_sealed_source                 BOOLEAN       NOT NULL,
  purpose_type                     VARCHAR(255)  NOT NULL,
  requested_possession_limit_mci   DOUBLE        NOT NULL,
  research_type                    VARCHAR(255)  NOT NULL,
  single_source_limit_mci          DOUBLE,
  vial_possession_limit_mci        DOUBLE,
  license_line_number_id          INTEGER,
  radionuclide_id                  INTEGER       NOT NULL,
  ua_id                            INTEGER       NOT NULL,
  physical_form_id                 INTEGER       NOT NULL,  
  PRIMARY KEY (ua_pw_id)
);

ALTER TABLE radsafety.campus
ADD CONSTRAINT UK_Code_Campus UNIQUE (code);

ALTER TABLE radsafety.radioActivityUnit
ADD CONSTRAINT UK_RadioActivityUnit_Description UNIQUE (unit_id,unit_name);

ALTER TABLE radsafety.license_line_number
ADD CONSTRAINT UK_LicenseId_LineNumber UNIQUE (license_id, line_number);

ALTER TABLE radsafety.core_bundle
ADD CONSTRAINT UK_CsId_CoreBundle UNIQUE (cs_id);

ALTER TABLE radsafety.location
ADD CONSTRAINT UK_CBPR_Location UNIQUE (campus_code, building_key, floor_key, room_key);

ALTER TABLE radsafety.person
ADD CONSTRAINT UK_EPPN_Person UNIQUE (eppn);

ALTER TABLE radsafety.radionuclide
ADD CONSTRAINT UK_Name_Radionuclide UNIQUE (name);

ALTER TABLE radsafety.ua_pw_attachment
ADD CONSTRAINT UK_AttachmentId_UAPWAttachment UNIQUE (attachment_id);

ALTER TABLE radsafety.training_attachment
ADD CONSTRAINT UK_AttachmentId_TrainingAttachment UNIQUE (attachment_id);

ALTER TABLE radsafety.ua_bundle_attachment
ADD CONSTRAINT UK_AttachmentId_UABAttachment UNIQUE (attachment_id);

ALTER TABLE radsafety.license_line_number_info
ADD CONSTRAINT FK_LicenseRule_RadioActivityUnit
FOREIGN KEY (possession_limit_unit_id)
REFERENCES radsafety.radioActivityUnit (unit_id);

ALTER TABLE radsafety.license_line_number_info
ADD CONSTRAINT FK_LicenseLineNumberInfo_Form
FOREIGN KEY (line_number_radionuclide_form_id)
REFERENCES radsafety.line_number_radionuclide_form (line_number_radionuclide_form_id);

ALTER TABLE radsafety.agreement
ADD CONSTRAINT FK_c58sp5byvw5tyr9oe3pjqbepf
FOREIGN KEY (created_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.agreement
ADD CONSTRAINT FK_2cpw9awmvfcdxs3ysaa0wj0db
FOREIGN KEY (last_modified_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.agreement
ADD CONSTRAINT FK_Agreement_Campus
FOREIGN KEY (campus_code)
REFERENCES radsafety.campus (code);

ALTER TABLE radsafety.comment
ADD CONSTRAINT FK_Comment_Person
FOREIGN KEY (reviewer_person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.comment
ADD CONSTRAINT FK_Comment_Ua
FOREIGN KEY (ua_id)
REFERENCES radsafety.ua (id);

ALTER TABLE radsafety.core_bundle
ADD CONSTRAINT FK_Core_Bundle_Person
FOREIGN KEY (pi_person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.core_bundle_location
ADD CONSTRAINT FK_Core_Bundle_Location_Bundle
FOREIGN KEY (core_bundle_id)
REFERENCES radsafety.core_bundle (id);

ALTER TABLE radsafety.core_bundle_location
ADD CONSTRAINT FK_Core_Bundle_Location_Location
FOREIGN KEY (location_id)
REFERENCES radsafety.location (id);

ALTER TABLE radsafety.core_bundle_person
ADD CONSTRAINT FK_Core_Bundle_Person_Bundle
FOREIGN KEY (core_bundle_id)
REFERENCES radsafety.core_bundle (id);

ALTER TABLE radsafety.core_bundle_person
ADD CONSTRAINT FK_Bundle_Person_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.core_bundle_person_role
ADD CONSTRAINT FK_Bpr_Bp
FOREIGN KEY (core_bundle_person_id)
REFERENCES radsafety.core_bundle_person (id);

ALTER TABLE radsafety.license
ADD CONSTRAINT FK_License_Campus
FOREIGN KEY (campus_code)
REFERENCES radsafety.campus (code);

ALTER TABLE radsafety.license
ADD CONSTRAINT FK_License_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.license
ADD CONSTRAINT FK_License_License_Type
FOREIGN KEY (license_type_id)
REFERENCES radsafety.license_type (license_type_id);

ALTER TABLE radsafety.license
ADD CONSTRAINT FK_License_LicenseRuleType
FOREIGN KEY (license_rule_type_id)
REFERENCES radsafety.license_rule_type (license_rule_type_id);

ALTER TABLE radsafety.license_line_number
ADD CONSTRAINT FK_License_Line_Number_License
FOREIGN KEY (license_id)
REFERENCES radsafety.license (license_id);

ALTER TABLE radsafety.license_line_number
ADD CONSTRAINT FK_LicenseLineNumber_LLNInfo
FOREIGN KEY (license_line_number_info_id)
REFERENCES radsafety.license_line_number_info (license_line_number_info_id);

--ALTER TABLE radsafety.license_radionuclide
--ADD CONSTRAINT FK_LicenseRadionuclide_License
--FOREIGN KEY (license_id)
--REFERENCES radsafety.license (license_id);

--ALTER TABLE radsafety.license_radionuclide
--ADD CONSTRAINT FK_LicenseRadionuclide_Radionuclide
--FOREIGN KEY (radionuclide_id)
--REFERENCES radsafety.radionuclide (radionuclide_id);

--ALTER TABLE radsafety.license_radionuclide
--ADD CONSTRAINT FK_LicenseRadionuclide_LicenseLineNumber
--FOREIGN KEY (license_line_number_id)
--REFERENCES radsafety.license_line_number (license_line_number_id);

ALTER TABLE radsafety.person
ADD CONSTRAINT FK_Person_Campus
FOREIGN KEY (campus_code)
REFERENCES radsafety.campus (code);

ALTER TABLE radsafety.person_dosimetry
ADD CONSTRAINT FK_PersonDosimetry_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.person_experience
ADD CONSTRAINT FK_PersonExperience_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.person_role
ADD CONSTRAINT FK_Person_Role_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.person_role
ADD CONSTRAINT FK_CB_PersonRole_Person
FOREIGN KEY (created_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.person_role
ADD CONSTRAINT FK_LM_PersonRole_Person
FOREIGN KEY (last_modified_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.person_training
ADD CONSTRAINT FK_PersonTraining_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.radionuclide
ADD CONSTRAINT FK_Radionuclide_DurationType
FOREIGN KEY (half_life_unit)
REFERENCES radsafety.duration_unit (duration_unit_id);

ALTER TABLE radsafety.soe
ADD CONSTRAINT FK_Soe_Ua
FOREIGN KEY (ua_id)
REFERENCES radsafety.ua (id);

ALTER TABLE radsafety.soe
ADD CONSTRAINT FK_Soe_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.ua_pw_attachment
ADD CONSTRAINT FK_al5j3nh4pngbl1qvvm0dxvsdc
FOREIGN KEY (attachment_id)
REFERENCES radsafety.attachment (attachment_id);

ALTER TABLE radsafety.ua_pw_attachment
ADD CONSTRAINT FK_iibivn5d0yhnhtl15089adi5o
FOREIGN KEY (ua_pw_id)
REFERENCES radsafety.ua_planned_work (ua_pw_id);

ALTER TABLE radsafety.soe_person_experience
ADD CONSTRAINT FK_SoePersonExperience_PersonExperience
FOREIGN KEY (person_experience_id)
REFERENCES radsafety.person_experience (id);

ALTER TABLE radsafety.soe_person_experience
ADD CONSTRAINT FK_SoePersonExperience_Soe
FOREIGN KEY (soe_id)
REFERENCES radsafety.soe (id);

ALTER TABLE radsafety.soe_person_dosimetry
ADD CONSTRAINT FK_SoePersonDosimetry_PersonDosimetry
FOREIGN KEY (person_dosimetry_id)
REFERENCES radsafety.person_dosimetry (id);

ALTER TABLE radsafety.soe_person_dosimetry
ADD CONSTRAINT FK_SoePersonDosimetry_Soe
FOREIGN KEY (soe_id)
REFERENCES radsafety.soe (id);

ALTER TABLE radsafety.soe_person_training
ADD CONSTRAINT FK_SoePersonTraining_PersonTraining
FOREIGN KEY (person_training_id)
REFERENCES radsafety.person_training (id);

ALTER TABLE radsafety.soe_person_training
ADD CONSTRAINT FK_SoePersonTraining_Soe
FOREIGN KEY (soe_id)
REFERENCES radsafety.soe (id);

ALTER TABLE radsafety.training_attachment
ADD CONSTRAINT FK_87ssg7c01g201amtdg5vrpplj
FOREIGN KEY (attachment_id)
REFERENCES radsafety.attachment (attachment_id);

ALTER TABLE radsafety.training_attachment
ADD CONSTRAINT FK_5cnxj8k7e3anoohjpqd44rrvv
FOREIGN KEY (person_training_id)
REFERENCES radsafety.person_training (id);

ALTER TABLE radsafety.ua
ADD CONSTRAINT FK_5hqayt3u87ebl9x56a88tqji5
FOREIGN KEY (created_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.ua
ADD CONSTRAINT FK_q9uvttpy143hajrv3j63ars15
FOREIGN KEY (last_modified_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.ua
ADD CONSTRAINT FK_Ua_Person
FOREIGN KEY (pi_person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.amendment
ADD CONSTRAINT FK_Amendment_Ua
FOREIGN KEY (ua_id)
REFERENCES radsafety.ua (id);

ALTER TABLE radsafety.amendment
ADD CONSTRAINT FK_CB_Amendment_Person
FOREIGN KEY (created_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.amendment
ADD CONSTRAINT FK_LM_Amendment_Person
FOREIGN KEY (last_modified_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.amendment_item
ADD CONSTRAINT FK_AmendmentItem_Amendment
FOREIGN KEY (amendment_id)
REFERENCES radsafety.amendment (amendment_id);

ALTER TABLE radsafety.amendment_item
ADD CONSTRAINT FK_CB_AmendmentItem_Person
FOREIGN KEY (created_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.amendment_item
ADD CONSTRAINT FK_LM_AmendmentItem_Person
FOREIGN KEY (last_modified_by)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.ua_bundle
ADD CONSTRAINT FK_UaBundle_Ua
FOREIGN KEY (ua_id)
REFERENCES radsafety.ua (id);

ALTER TABLE radsafety.ua_bundle_location
ADD CONSTRAINT FK_UaBundleLocation_Location
FOREIGN KEY (location_id)
REFERENCES radsafety.location (id);

ALTER TABLE radsafety.ua_bundle_location
ADD CONSTRAINT FK_UaBundleLocation_UaBundle
FOREIGN KEY (ua_bundle_id)
REFERENCES radsafety.ua_bundle (id);

ALTER TABLE radsafety.ua_bundle_person
ADD CONSTRAINT FK_UaBundlePerson_Person
FOREIGN KEY (person_id)
REFERENCES radsafety.person (id);

ALTER TABLE radsafety.ua_bundle_person
ADD CONSTRAINT FK_UaBundlePerson_UaBundle
FOREIGN KEY (ua_bundle_id)
REFERENCES radsafety.ua_bundle (id);

ALTER TABLE radsafety.ua_bundle_attachment
ADD CONSTRAINT FK_ua_bundle_attachment
FOREIGN KEY (attachment_id)
REFERENCES radsafety.attachment (attachment_id);

ALTER TABLE radsafety.ua_bundle_attachment
ADD CONSTRAINT FK_attachment_ua_bundle
FOREIGN KEY (ua_bundle_id)
REFERENCES radsafety.ua_bundle (id);

ALTER TABLE radsafety.ua_planned_work
ADD CONSTRAINT FK_UPW_LLN
FOREIGN KEY (license_line_number_id)
REFERENCES radsafety.license_line_number (license_line_number_id);

ALTER TABLE radsafety.ua_planned_work
ADD CONSTRAINT FK_UaPlannedWork_Radionuclide
FOREIGN KEY (radionuclide_id)
REFERENCES radsafety.radionuclide (radionuclide_id);

ALTER TABLE radsafety.ua_planned_work
ADD CONSTRAINT FK_UaPlannedWork_Ua
FOREIGN KEY (ua_id)
REFERENCES radsafety.ua (id);

ALTER TABLE radsafety.ua_planned_work
ADD CONSTRAINT FK_UaPlannedWork_PhysicalForm
FOREIGN KEY (physical_form_id)
REFERENCES radsafety.physical_form (physical_form_id);