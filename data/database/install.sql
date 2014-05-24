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

CREATE TABLE `accountloginbans` (
	`accountloginban_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`account_id` BIGINT(20) UNSIGNED NOT NULL,
	`end` TIMESTAMP NOT NULL,
	PRIMARY KEY (`accountloginban_id`),
	UNIQUE KEY `account_id` (`account_id`)
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
