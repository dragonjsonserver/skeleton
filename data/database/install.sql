CREATE TABLE `accounts` (
	`account_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sessions` (
	`session_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`sessionhash` CHAR(32) NOT NULL,
	`data` TEXT NOT NULL,
	PRIMARY KEY (`session_id`),
	UNIQUE KEY `sessionhash` (`sessionhash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `accountachievements` (
	`accountachievement_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`gamedesign_identifier` VARCHAR(255) NOT NULL,
	`data` TEXT NOT NULL,
	`level` INTEGER(11) NOT NULL,
	PRIMARY KEY (`accountachievement_id`),
	UNIQUE KEY `account_id` (`account_id`, `gamedesign_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `accountloginbans` (
	`accountloginban_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`end` TIMESTAMP NOT NULL,
	PRIMARY KEY (`accountloginban_id`),
	UNIQUE KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `alliances` (
	`alliance_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`gameround_id` BIGINT(20) UNSIGNED NOT NULL,
	`tag` VARCHAR(255) NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	`description` TEXT NULL,
	PRIMARY KEY (`alliance_id`),
	UNIQUE KEY `tag` (`gameround_id`, `tag`),
	UNIQUE KEY `name` (`gameround_id`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `allianceavatars` (
	`allianceavatar_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`avatar_id` BIGINT(20) UNSIGNED NOT NULL,
	`alliance_id` BIGINT(20) UNSIGNED NOT NULL,
	`role` ENUM('applicant', 'member', 'leader') NOT NULL,
	PRIMARY KEY (`allianceavatar_id`),
	UNIQUE KEY `avatar_id` (`avatar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `allianceachievements` (
	`allianceachievement_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`alliance_id` BIGINT(20) UNSIGNED NOT NULL,
	`gamedesign_identifier` VARCHAR(255) NOT NULL,
	`data` TEXT NOT NULL,
	`level` INTEGER(11) NOT NULL,
	PRIMARY KEY (`allianceachievement_id`),
	UNIQUE KEY `alliance_id` (`alliance_id`, `gamedesign_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `avatars` (
	`avatar_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`gameround_id` BIGINT(20) UNSIGNED NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`avatar_id`),
	UNIQUE KEY `gameround_id` (`gameround_id`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `avatarachievements` (
	`avatarachievement_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`avatar_id` BIGINT(20) UNSIGNED NOT NULL,
	`gamedesign_identifier` VARCHAR(255) NOT NULL,
	`data` TEXT NOT NULL,
	`level` INTEGER(11) NOT NULL,
	PRIMARY KEY (`avatarachievement_id`),
	UNIQUE KEY `avatar_id` (`avatar_id`, `gamedesign_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `avatarloginbans` (
	`avatarloginban_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`avatar_id` BIGINT(20) UNSIGNED NOT NULL,
	`end` TIMESTAMP NOT NULL,
	PRIMARY KEY (`avatarloginban_id`),
	UNIQUE KEY `avatar_id` (`avatar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `avatarmessages` (
	`avatarmessage_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`from_avatar_id` BIGINT(20) UNSIGNED NULL,
	`to_avatar_id` BIGINT(20) UNSIGNED NOT NULL,
	`subject` VARCHAR(255) NOT NULL,
	`content` TEXT NOT NULL,
	`from_state` ENUM('read', 'delete') NOT NULL,
	`to_state` ENUM('new', 'read', 'delete') NOT NULL,
	PRIMARY KEY (`avatarmessage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `avatarmutebans` (
	`avatarmuteban_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`avatar_id` BIGINT(20) UNSIGNED NOT NULL,
	`end` TIMESTAMP NOT NULL,
	PRIMARY KEY (`avatarmuteban_id`),
	UNIQUE KEY `avatar_id` (`avatar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `devices` (
	`device_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`platform` VARCHAR(255) NOT NULL,
	`credentials` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`device_id`),
	UNIQUE KEY (`platform`, `credentials`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `emailaddresses` (
	`emailaddress_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`emailaddress` VARCHAR(255) NOT NULL,
	`passwordcrypt` CHAR(60) BINARY NOT NULL,
	PRIMARY KEY (`emailaddress_id`),
	UNIQUE KEY `account_id` (`account_id`),
	UNIQUE KEY `emailaddress` (`emailaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `validationrequests` (
	`validationrequest_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modified` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`emailaddress_id` BIGINT(20) UNSIGNED NOT NULL,
	`validationrequesthash` CHAR(32) BINARY NOT NULL,
	PRIMARY KEY (`validationrequest_id`),
	UNIQUE KEY `emailaddress_id` (`emailaddress_id`),
	UNIQUE KEY `validationrequesthash` (`validationrequesthash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `passwordrequests` (
	`passwordrequest_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`emailaddress_id` BIGINT(20) UNSIGNED NOT NULL,
	`passwordrequesthash` CHAR(32) BINARY NOT NULL,
	PRIMARY KEY (`passwordrequest_id`),
	UNIQUE KEY `passwordrequesthash` (`passwordrequesthash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `gamerounds` (
	`gameround_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`language` CHAR(2) NULL,
	`bot` BOOLEAN NOT NULL,
	`progress` INTEGER(11) NOT NULL,
	`active` BOOLEAN NOT NULL,
	`event` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`gameround_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `requestlogs` (
	`requestlog_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`method` VARCHAR(255) NOT NULL,
	`id` INT(10) NOT NULL,
	`classname` VARCHAR(255) NOT NULL,
	`methodname` VARCHAR(255) NOT NULL,
	`params` TEXT NOT NULL,
	`response` TEXT NOT NULL,
	`session` TEXT NULL,
	PRIMARY KEY (`requestlog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
