START TRANSACTION;


CREATE TABLE `accept_estimates` (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `estimate_id` int UNSIGNED NOT NULL,
                                    `full_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `signature` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
                               `id` int UNSIGNED NOT NULL,
                               `user_id` int UNSIGNED NOT NULL,
                               `clock_in_time` datetime NOT NULL,
                               `clock_out_time` datetime DEFAULT NULL,
                               `clock_in_ip` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `clock_out_ip` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `working_from` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'office',
                               `late` enum('yes','no') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                               `half_day` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance_settings`
--

CREATE TABLE `attendance_settings` (
                                       `id` int UNSIGNED NOT NULL,
                                       `office_start_time` time NOT NULL,
                                       `office_end_time` time NOT NULL,
                                       `halfday_mark_time` time DEFAULT NULL,
                                       `late_mark_duration` tinyint NOT NULL,
                                       `clockin_in_day` int NOT NULL DEFAULT '1',
                                       `employee_clock_in_out` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'yes',
                                       `office_open_days` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '[1,2,3,4,5]',
                                       `ip_address` text COLLATE utf8mb3_unicode_ci,
                                       `radius` int DEFAULT NULL,
                                       `radius_check` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                       `ip_check` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `attendance_settings`
--

INSERT INTO `attendance_settings` (`id`, `office_start_time`, `office_end_time`, `halfday_mark_time`, `late_mark_duration`, `clockin_in_day`, `employee_clock_in_out`, `office_open_days`, `ip_address`, `radius`, `radius_check`, `ip_check`, `created_at`, `updated_at`) VALUES
    (1, '09:00:00', '18:00:00', NULL, 20, 2, 'yes', '[1,2,3,4,5]', NULL, NULL, 'no', 'no', '2023-02-21 05:51:48', '2023-02-21 05:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `client_categories`
--

CREATE TABLE `client_categories` (
                                     `id` bigint UNSIGNED NOT NULL,
                                     `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_contacts`
--

CREATE TABLE `client_contacts` (
                                   `id` int UNSIGNED NOT NULL,
                                   `user_id` int UNSIGNED NOT NULL,
                                   `contact_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `phone` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `email` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_details`
--

CREATE TABLE `client_details` (
                                  `id` int UNSIGNED NOT NULL,
                                  `user_id` int UNSIGNED NOT NULL,
                                  `company_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `address` text COLLATE utf8mb3_unicode_ci,
                                  `shipping_address` text COLLATE utf8mb3_unicode_ci,
                                  `postal_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `state` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `city` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `office` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `website` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `note` text COLLATE utf8mb3_unicode_ci,
                                  `linkedin` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `facebook` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `twitter` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `skype` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `gst_number` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL,
                                  `category_id` bigint UNSIGNED DEFAULT NULL,
                                  `sub_category_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_sub_categories`
--

CREATE TABLE `client_sub_categories` (
                                         `id` bigint UNSIGNED NOT NULL,
                                         `category_id` bigint UNSIGNED NOT NULL,
                                         `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
                             `id` bigint UNSIGNED NOT NULL,
                             `client_id` int UNSIGNED NOT NULL,
                             `subject` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                             `amount` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                             `original_amount` decimal(15,2) NOT NULL,
                             `contract_type_id` bigint UNSIGNED DEFAULT NULL,
                             `start_date` date NOT NULL,
                             `original_start_date` date NOT NULL,
                             `end_date` date DEFAULT NULL,
                             `original_end_date` date DEFAULT NULL,
                             `description` longtext COLLATE utf8mb3_unicode_ci,
                             `contract_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `company_logo` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `alternate_address` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `cell` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `office` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `city` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `state` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `country` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `postal_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `contract_detail` longtext COLLATE utf8mb3_unicode_ci,
                             `created_at` timestamp NULL DEFAULT NULL,
                             `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract_discussions`
--

CREATE TABLE `contract_discussions` (
                                        `id` bigint UNSIGNED NOT NULL,
                                        `contract_id` bigint UNSIGNED NOT NULL,
                                        `from` int UNSIGNED NOT NULL,
                                        `message` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
                                        `created_at` timestamp NULL DEFAULT NULL,
                                        `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract_files`
--

CREATE TABLE `contract_files` (
                                  `id` int UNSIGNED NOT NULL,
                                  `user_id` int UNSIGNED NOT NULL,
                                  `contract_id` bigint UNSIGNED NOT NULL,
                                  `filename` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `hashname` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `size` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `google_url` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `dropbox_link` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `external_link_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `external_link` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `description` text COLLATE utf8mb3_unicode_ci,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract_renews`
--

CREATE TABLE `contract_renews` (
                                   `id` bigint UNSIGNED NOT NULL,
                                   `renewed_by` int UNSIGNED NOT NULL,
                                   `contract_id` bigint UNSIGNED NOT NULL,
                                   `start_date` date NOT NULL,
                                   `end_date` date NOT NULL,
                                   `amount` decimal(12,2) NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract_signs`
--

CREATE TABLE `contract_signs` (
                                  `id` bigint UNSIGNED NOT NULL,
                                  `contract_id` bigint UNSIGNED NOT NULL,
                                  `full_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `signature` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract_types`
--

CREATE TABLE `contract_types` (
                                  `id` bigint UNSIGNED NOT NULL,
                                  `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation`
--

CREATE TABLE `conversation` (
                                `id` int UNSIGNED NOT NULL,
                                `user_one` int UNSIGNED NOT NULL,
                                `user_two` int UNSIGNED NOT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_reply`
--

CREATE TABLE `conversation_reply` (
                                      `id` int UNSIGNED NOT NULL,
                                      `conversation_id` int UNSIGNED NOT NULL,
                                      `reply` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `user_id` int UNSIGNED NOT NULL,
                                      `created_at` timestamp NULL DEFAULT NULL,
                                      `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
                             `id` int UNSIGNED NOT NULL,
                             `iso` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
                             `name` varchar(80) COLLATE utf8mb3_unicode_ci NOT NULL,
                             `nicename` varchar(80) COLLATE utf8mb3_unicode_ci NOT NULL,
                             `iso3` char(3) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `numcode` smallint DEFAULT NULL,
                             `phonecode` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`) VALUES
                                                                                              (1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93),
                                                                                              (2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355),
                                                                                              (3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213),
                                                                                              (4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684),
                                                                                              (5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376),
                                                                                              (6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244),
                                                                                              (7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264),
                                                                                              (8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL, NULL, 0),
                                                                                              (9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268),
                                                                                              (10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54),
                                                                                              (11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374),
                                                                                              (12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297),
                                                                                              (13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61),
                                                                                              (14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43),
                                                                                              (15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994),
                                                                                              (16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242),
                                                                                              (17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973),
                                                                                              (18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880),
                                                                                              (19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246),
                                                                                              (20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375),
                                                                                              (21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32),
                                                                                              (22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501),
                                                                                              (23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229),
                                                                                              (24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441),
                                                                                              (25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975),
                                                                                              (26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591),
                                                                                              (27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387),
                                                                                              (28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267),
                                                                                              (29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, 0),
                                                                                              (30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55),
                                                                                              (31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, 246),
                                                                                              (32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673),
                                                                                              (33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359),
                                                                                              (34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226),
                                                                                              (35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257),
                                                                                              (36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855),
                                                                                              (37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237),
                                                                                              (38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1),
                                                                                              (39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238),
                                                                                              (40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345),
                                                                                              (41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236),
                                                                                              (42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235),
                                                                                              (43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56),
                                                                                              (44, 'CN', 'CHINA', 'China', 'CHN', 156, 86),
                                                                                              (45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, 61),
                                                                                              (46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, 672),
                                                                                              (47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57),
                                                                                              (48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269),
                                                                                              (49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242),
                                                                                              (50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 242),
                                                                                              (51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682),
                                                                                              (52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506),
                                                                                              (53, 'CI', 'COTE D\'IVOIRE', 'Cote D\'Ivoire', 'CIV', 384, 225),
                                                                                              (54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385),
                                                                                              (55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53),
                                                                                              (56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357),
                                                                                              (57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420),
                                                                                              (58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45),
                                                                                              (59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253),
                                                                                              (60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767),
                                                                                              (61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809),
                                                                                              (62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593),
                                                                                              (63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20),
                                                                                              (64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503),
                                                                                              (65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240),
                                                                                              (66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291),
                                                                                              (67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372),
                                                                                              (68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251),
                                                                                              (69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500),
                                                                                              (70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298),
                                                                                              (71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679),
                                                                                              (72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358),
                                                                                              (73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33),
                                                                                              (74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594),
                                                                                              (75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689),
                                                                                              (76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, 0),
                                                                                              (77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241),
                                                                                              (78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220),
                                                                                              (79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995),
                                                                                              (80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49),
                                                                                              (81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233),
                                                                                              (82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350),
                                                                                              (83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30),
                                                                                              (84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299),
                                                                                              (85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473),
                                                                                              (86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590),
                                                                                              (87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671),
                                                                                              (88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502),
                                                                                              (89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224),
                                                                                              (90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245),
                                                                                              (91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592),
                                                                                              (92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509),
                                                                                              (93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL, NULL, 0),
                                                                                              (94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39),
                                                                                              (95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504),
                                                                                              (96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852),
                                                                                              (97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36),
                                                                                              (98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354),
                                                                                              (99, 'IN', 'INDIA', 'India', 'IND', 356, 91),
                                                                                              (100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62),
                                                                                              (101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98),
                                                                                              (102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964),
                                                                                              (103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353),
                                                                                              (104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972),
                                                                                              (105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39),
                                                                                              (106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876),
                                                                                              (107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81),
                                                                                              (108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962),
                                                                                              (109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7),
                                                                                              (110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254),
                                                                                              (111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686),
                                                                                              (112, 'KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'Korea, Democratic People\'s Republic of', 'PRK', 408, 850),
                                                                                              (113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82),
                                                                                              (114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965),
                                                                                              (115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996),
                                                                                              (116, 'LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'Lao People\'s Democratic Republic', 'LAO', 418, 856),
                                                                                              (117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371),
                                                                                              (118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961),
                                                                                              (119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266),
                                                                                              (120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231),
                                                                                              (121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218),
                                                                                              (122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423),
                                                                                              (123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370),
                                                                                              (124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352),
                                                                                              (125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853),
                                                                                              (126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389),
                                                                                              (127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261),
                                                                                              (128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265),
                                                                                              (129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60),
                                                                                              (130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960),
                                                                                              (131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223),
                                                                                              (132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356),
                                                                                              (133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692),
                                                                                              (134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596),
                                                                                              (135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222),
                                                                                              (136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230),
                                                                                              (137, 'YT', 'MAYOTTE', 'Mayotte', NULL, NULL, 269),
                                                                                              (138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52),
                                                                                              (139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691),
                                                                                              (140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373),
                                                                                              (141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377),
                                                                                              (142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976),
                                                                                              (143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664),
                                                                                              (144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212),
                                                                                              (145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258),
                                                                                              (146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95),
                                                                                              (147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264),
                                                                                              (148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674),
                                                                                              (149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977),
                                                                                              (150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31),
                                                                                              (151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599),
                                                                                              (152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687),
                                                                                              (153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64),
                                                                                              (154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505),
                                                                                              (155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227),
                                                                                              (156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234),
                                                                                              (157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683),
                                                                                              (158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672),
                                                                                              (159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670),
                                                                                              (160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47),
                                                                                              (161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968),
                                                                                              (162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92),
                                                                                              (163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680),
                                                                                              (164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, 970),
                                                                                              (165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507),
                                                                                              (166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675),
                                                                                              (167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595),
                                                                                              (168, 'PE', 'PERU', 'Peru', 'PER', 604, 51),
                                                                                              (169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63),
                                                                                              (170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0),
                                                                                              (171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48),
                                                                                              (172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351),
                                                                                              (173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787),
                                                                                              (174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974),
                                                                                              (175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262),
                                                                                              (176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40),
                                                                                              (177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 70),
                                                                                              (178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250),
                                                                                              (179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290),
                                                                                              (180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869),
                                                                                              (181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758),
                                                                                              (182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508),
                                                                                              (183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784),
                                                                                              (184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684),
                                                                                              (185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378),
                                                                                              (186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239),
                                                                                              (187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966),
                                                                                              (188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221),
                                                                                              (189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL, NULL, 381),
                                                                                              (190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248),
                                                                                              (191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232),
                                                                                              (192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65),
                                                                                              (193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421),
                                                                                              (194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386),
                                                                                              (195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677),
                                                                                              (196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252),
                                                                                              (197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27),
                                                                                              (198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, 0),
                                                                                              (199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34),
                                                                                              (200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94),
                                                                                              (201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249),
                                                                                              (202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597),
                                                                                              (203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47),
                                                                                              (204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268),
                                                                                              (205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46),
                                                                                              (206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41),
                                                                                              (207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963),
                                                                                              (208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886),
                                                                                              (209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992),
                                                                                              (210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255),
                                                                                              (211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66),
                                                                                              (212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL, NULL, 670),
                                                                                              (213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228),
                                                                                              (214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690),
                                                                                              (215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676),
                                                                                              (216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868),
                                                                                              (217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216),
                                                                                              (218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90),
                                                                                              (219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370),
                                                                                              (220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649),
                                                                                              (221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688),
                                                                                              (222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256),
                                                                                              (223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380),
                                                                                              (224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971),
                                                                                              (225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44),
                                                                                              (226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1),
                                                                                              (227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, 1),
                                                                                              (228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598),
                                                                                              (229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998),
                                                                                              (230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678),
                                                                                              (231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58),
                                                                                              (232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84),
                                                                                              (233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284),
                                                                                              (234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340),
                                                                                              (235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681),
                                                                                              (236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212),
                                                                                              (237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967),
                                                                                              (238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260),
                                                                                              (239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263),
                                                                                              (240, 'RS', 'SERBIA', 'Serbia', 'SRB', 688, 381),
                                                                                              (241, 'AP', 'ASIA PACIFIC REGION', 'Asia / Pacific Region', '0', 0, 0),
                                                                                              (242, 'ME', 'MONTENEGRO', 'Montenegro', 'MNE', 499, 382),
                                                                                              (243, 'AX', 'ALAND ISLANDS', 'Aland Islands', 'ALA', 248, 358),
                                                                                              (244, 'BQ', 'BONAIRE, SINT EUSTATIUS AND SABA', 'Bonaire, Sint Eustatius and Saba', 'BES', 535, 599),
                                                                                              (245, 'CW', 'CURACAO', 'Curacao', 'CUW', 531, 599),
                                                                                              (246, 'GG', 'GUERNSEY', 'Guernsey', 'GGY', 831, 44),
                                                                                              (247, 'IM', 'ISLE OF MAN', 'Isle of Man', 'IMN', 833, 44),
                                                                                              (248, 'JE', 'JERSEY', 'Jersey', 'JEY', 832, 44),
                                                                                              (249, 'XK', 'KOSOVO', 'Kosovo', '---', 0, 381),
                                                                                              (250, 'BL', 'SAINT BARTHELEMY', 'Saint Barthelemy', 'BLM', 652, 590),
                                                                                              (251, 'MF', 'SAINT MARTIN', 'Saint Martin', 'MAF', 663, 590),
                                                                                              (252, 'SX', 'SINT MAARTEN', 'Sint Maarten', 'SXM', 534, 1),
                                                                                              (253, 'SS', 'SOUTH SUDAN', 'South Sudan', 'SSD', 728, 211);

-- --------------------------------------------------------

--
-- Table structure for table `credit_notes`
--

CREATE TABLE `credit_notes` (
                                `id` int UNSIGNED NOT NULL,
                                `project_id` int UNSIGNED DEFAULT NULL,
                                `client_id` int UNSIGNED DEFAULT NULL,
                                `cn_number` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                `invoice_id` int UNSIGNED DEFAULT NULL,
                                `issue_date` date NOT NULL,
                                `due_date` date NOT NULL,
                                `discount` double NOT NULL DEFAULT '0',
                                `discount_type` enum('percent','fixed') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'percent',
                                `sub_total` double(15,2) NOT NULL,
  `total` double(15,2) NOT NULL,
  `currency_id` int UNSIGNED DEFAULT NULL,
  `status` enum('closed','open') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'open',
  `recurring` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
  `billing_frequency` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `billing_interval` int DEFAULT NULL,
  `billing_cycle` int DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file_original_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `credit_notes_invoice`
--

CREATE TABLE `credit_notes_invoice` (
                                        `id` bigint UNSIGNED NOT NULL,
                                        `credit_notes_id` bigint UNSIGNED NOT NULL,
                                        `invoice_id` bigint UNSIGNED NOT NULL,
                                        `date` datetime NOT NULL,
                                        `credit_amount` double(16,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `credit_note_items`
--

CREATE TABLE `credit_note_items` (
                                     `id` int UNSIGNED NOT NULL,
                                     `credit_note_id` int UNSIGNED NOT NULL,
                                     `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `type` enum('item','discount','tax') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'item',
                                     `quantity` int NOT NULL,
                                     `unit_price` double(8,2) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `taxes` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
                              `id` int UNSIGNED NOT NULL,
                              `currency_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `currency_symbol` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `currency_code` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `exchange_rate` double DEFAULT NULL,
                              `is_cryptocurrency` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                              `usd_price` double DEFAULT NULL,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `currency_name`, `currency_symbol`, `currency_code`, `exchange_rate`, `is_cryptocurrency`, `usd_price`, `created_at`, `updated_at`) VALUES
                                                                                                                                                                        (1, 'Dollars', '$', 'USD', NULL, 'no', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                                                                                        (2, 'Pounds', '£', 'GBP', NULL, 'no', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                                                                                        (3, 'Euros', '€', 'EUR', NULL, 'no', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                                                                                        (4, 'Rupee', '₹', 'INR', NULL, 'no', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
                                 `id` int UNSIGNED NOT NULL,
                                 `custom_field_group_id` int UNSIGNED DEFAULT NULL,
                                 `label` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `type` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `required` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                 `values` varchar(5000) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields_data`
--

CREATE TABLE `custom_fields_data` (
                                      `id` int UNSIGNED NOT NULL,
                                      `custom_field_id` int UNSIGNED NOT NULL,
                                      `model_id` int UNSIGNED NOT NULL,
                                      `model` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                      `value` varchar(10000) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_field_groups`
--

CREATE TABLE `custom_field_groups` (
                                       `id` int UNSIGNED NOT NULL,
                                       `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                       `model` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `custom_field_groups`
--

INSERT INTO `custom_field_groups` (`id`, `name`, `model`) VALUES
                                                              (1, 'Client', 'App\\ClientDetails'),
                                                              (2, 'Employee', 'App\\EmployeeDetails'),
                                                              (3, 'Project', 'App\\Project'),
                                                              (4, 'Invoice', 'App\\Invoice'),
                                                              (5, 'Estimate', 'App\\Estimate'),
                                                              (6, 'Task', 'App\\Task'),
                                                              (7, 'Expense', 'App\\Expense'),
                                                              (8, 'Lead', 'App\\Lead');

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_widgets`
--

CREATE TABLE `dashboard_widgets` (
                                     `id` bigint UNSIGNED NOT NULL,
                                     `widget_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `status` tinyint(1) NOT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL,
                                     `dashboard_type` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `dashboard_widgets`
--

INSERT INTO `dashboard_widgets` (`id`, `widget_name`, `status`, `created_at`, `updated_at`, `dashboard_type`) VALUES
                                                                                                                  (1, 'total_clients', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (2, 'total_employees', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (3, 'total_projects', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (4, 'total_unpaid_invoices', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (5, 'total_hours_logged', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (6, 'total_pending_tasks', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (7, 'total_today_attendance', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (8, 'total_unresolved_tickets', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (9, 'recent_earnings', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (10, 'settings_leaves', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (11, 'new_tickets', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (12, 'overdue_tasks', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (13, 'pending_follow_up', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (14, 'project_activity_timeline', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (15, 'user_activity_timeline', 1, '2023-02-21 05:51:54', '2023-02-21 05:51:58', 'admin-dashboard'),
                                                                                                                  (16, 'total_clients', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (17, 'total_leads', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (18, 'total_lead_conversions', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (19, 'total_contracts_generated', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (20, 'total_contracts_signed', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (21, 'client_wise_earnings', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (22, 'client_wise_timelogs', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (23, 'lead_vs_status', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (24, 'lead_vs_source', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (25, 'latest_client', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (26, 'recent_login_activities', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-client-dashboard'),
                                                                                                                  (27, 'total_paid_invoices', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (28, 'total_expenses', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (29, 'total_earnings', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (30, 'total_profit', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (31, 'total_pending_amount', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (32, 'invoice_overview', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (33, 'estimate_overview', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (34, 'proposal_overview', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (35, 'invoice_tab', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (36, 'estimate_tab', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (37, 'expense_tab', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (38, 'payment_tab', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (39, 'due_payments_tab', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (40, 'proposal_tab', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (41, 'earnings_by_client', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (42, 'earnings_by_projects', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-finance-dashboard'),
                                                                                                                  (43, 'total_leaves_approved', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (44, 'total_new_employee', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (45, 'total_employee_exits', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (46, 'average_attendance', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (47, 'department_wise_employee', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (48, 'designation_wise_employee', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (49, 'gender_wise_employee', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (50, 'role_wise_employee', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (51, 'leaves_taken', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (52, 'late_attendance_mark', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-hr-dashboard'),
                                                                                                                  (53, 'total_project', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-project-dashboard'),
                                                                                                                  (54, 'total_hours_logged', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-project-dashboard'),
                                                                                                                  (55, 'total_overdue_project', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-project-dashboard'),
                                                                                                                  (56, 'status_wise_project', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-project-dashboard'),
                                                                                                                  (57, 'pending_milestone', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-project-dashboard'),
                                                                                                                  (58, 'total_unresolved_tickets', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-ticket-dashboard'),
                                                                                                                  (59, 'total_unassigned_ticket', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-ticket-dashboard'),
                                                                                                                  (60, 'type_wise_ticket', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-ticket-dashboard'),
                                                                                                                  (61, 'status_wise_ticket', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-ticket-dashboard'),
                                                                                                                  (62, 'channel_wise_ticket', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-ticket-dashboard'),
                                                                                                                  (63, 'new_tickets', 1, '2023-02-21 05:51:58', '2023-02-21 05:51:58', 'admin-ticket-dashboard');

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
                                `id` bigint UNSIGNED NOT NULL,
                                `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discussions`
--

CREATE TABLE `discussions` (
                               `id` int UNSIGNED NOT NULL,
                               `discussion_category_id` int UNSIGNED NOT NULL DEFAULT '1',
                               `project_id` int UNSIGNED DEFAULT NULL,
                               `title` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `color` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT '#232629',
                               `user_id` int UNSIGNED NOT NULL,
                               `pinned` tinyint(1) NOT NULL DEFAULT '0',
                               `closed` tinyint(1) NOT NULL DEFAULT '0',
                               `deleted_at` timestamp NULL DEFAULT NULL,
                               `last_reply_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL,
                               `best_answer_id` int UNSIGNED DEFAULT NULL,
                               `last_reply_by_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discussion_categories`
--

CREATE TABLE `discussion_categories` (
                                         `id` int UNSIGNED NOT NULL,
                                         `order` int NOT NULL DEFAULT '1',
                                         `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `color` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `discussion_categories`
--

INSERT INTO `discussion_categories` (`id`, `order`, `name`, `color`, `created_at`, `updated_at`) VALUES
    (1, 1, 'General', '#3498DB', '2023-02-21 05:51:57', '2023-02-21 05:51:57');

-- --------------------------------------------------------

--
-- Table structure for table `discussion_replies`
--

CREATE TABLE `discussion_replies` (
                                      `id` int UNSIGNED NOT NULL,
                                      `discussion_id` int UNSIGNED NOT NULL,
                                      `user_id` int UNSIGNED NOT NULL,
                                      `body` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `deleted_at` timestamp NULL DEFAULT NULL,
                                      `created_at` timestamp NULL DEFAULT NULL,
                                      `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_notification_settings`
--

CREATE TABLE `email_notification_settings` (
                                               `id` int UNSIGNED NOT NULL,
                                               `setting_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                               `send_email` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                               `send_slack` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                               `send_push` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                               `created_at` timestamp NULL DEFAULT NULL,
                                               `updated_at` timestamp NULL DEFAULT NULL,
                                               `slug` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `email_notification_settings`
--

INSERT INTO `email_notification_settings` (`id`, `setting_name`, `send_email`, `send_slack`, `send_push`, `created_at`, `updated_at`, `slug`) VALUES
                                                                                                                                                  (1, 'New Expense/Added by Admin', 'yes', 'no', 'no', '2023-02-21 05:51:48', '2023-02-21 05:51:56', 'new-expenseadded-by-admin'),
                                                                                                                                                  (2, 'New Expense/Added by Member', 'yes', 'no', 'no', '2023-02-21 05:51:48', '2023-02-21 05:51:56', 'new-expenseadded-by-member'),
                                                                                                                                                  (3, 'Expense Status Changed', 'yes', 'no', 'no', '2023-02-21 05:51:48', '2023-02-21 05:51:56', 'expense-status-changed'),
                                                                                                                                                  (4, 'New Support Ticket Request', 'yes', 'no', 'no', '2023-02-21 05:51:48', '2023-02-21 05:51:56', 'new-support-ticket-request'),
                                                                                                                                                  (5, 'New Leave Application', 'yes', 'no', 'no', '2023-02-21 05:51:49', '2023-02-21 05:51:56', 'new-leave-application'),
                                                                                                                                                  (6, 'Task Completed', 'yes', 'no', 'no', '2023-02-21 05:51:49', '2023-02-21 05:51:56', 'task-completed'),
                                                                                                                                                  (7, 'Invoice Create/Update Notification', 'yes', 'no', 'no', '2023-02-21 05:51:53', '2023-02-21 05:51:56', 'invoice-createupdate-notification'),
                                                                                                                                                  (8, 'Discussion Reply', 'yes', 'no', 'no', '2023-02-21 05:51:57', '2023-02-21 05:51:57', 'discussion-reply'),
                                                                                                                                                  (9, 'New Product Purchase Request', 'yes', 'no', 'no', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 'new-product-purchase-request'),
                                                                                                                                                  (10, 'Lead notification', 'yes', 'no', 'no', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 'lead-notification'),
                                                                                                                                                  (11, 'User Registration/Added by Admin', 'yes', 'no', 'no', '2023-02-21 05:52:02', '2023-02-21 05:52:02', 'user-registrationadded-by-admin'),
                                                                                                                                                  (12, 'Employee Assign to Project', 'yes', 'no', 'no', '2023-02-21 05:52:02', '2023-02-21 05:52:02', 'employee-assign-to-project'),
                                                                                                                                                  (13, 'New Notice Published', 'no', 'no', 'no', '2023-02-21 05:52:02', '2023-02-21 05:52:02', 'new-notice-published'),
                                                                                                                                                  (14, 'User Assign to Task', 'yes', 'no', 'no', '2023-02-21 05:52:02', '2023-02-21 05:52:02', 'user-assign-to-task');

-- --------------------------------------------------------

--
-- Table structure for table `employee_details`
--

CREATE TABLE `employee_details` (
                                    `id` int UNSIGNED NOT NULL,
                                    `user_id` int UNSIGNED NOT NULL,
                                    `employee_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                    `address` text COLLATE utf8mb3_unicode_ci,
                                    `hourly_rate` double DEFAULT NULL,
                                    `slack_username` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                    `department_id` int UNSIGNED DEFAULT NULL,
                                    `designation_id` bigint UNSIGNED DEFAULT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL,
                                    `joining_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    `last_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_docs`
--

CREATE TABLE `employee_docs` (
                                 `id` int UNSIGNED NOT NULL,
                                 `user_id` int UNSIGNED NOT NULL,
                                 `name` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `filename` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `hashname` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `size` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_leave_quotas`
--

CREATE TABLE `employee_leave_quotas` (
                                         `id` bigint UNSIGNED NOT NULL,
                                         `user_id` int UNSIGNED NOT NULL,
                                         `leave_type_id` int UNSIGNED NOT NULL,
                                         `no_of_leaves` int NOT NULL,
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `employee_skills`
--

CREATE TABLE `employee_skills` (
                                   `id` int UNSIGNED NOT NULL,
                                   `user_id` int UNSIGNED NOT NULL,
                                   `skill_id` int UNSIGNED NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_teams`
--

CREATE TABLE `employee_teams` (
                                  `id` int UNSIGNED NOT NULL,
                                  `team_id` int UNSIGNED NOT NULL,
                                  `user_id` int UNSIGNED NOT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `estimates`
--

CREATE TABLE `estimates` (
                             `id` int UNSIGNED NOT NULL,
                             `client_id` int UNSIGNED NOT NULL,
                             `estimate_number` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                             `valid_till` date NOT NULL,
                             `sub_total` double(16,2) NOT NULL,
  `discount` double NOT NULL DEFAULT '0',
  `discount_type` enum('percent','fixed') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'percent',
  `total` double(16,2) NOT NULL,
  `currency_id` int UNSIGNED DEFAULT NULL,
  `status` enum('declined','accepted','waiting','sent','draft','canceled') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'waiting',
  `note` mediumtext COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `send_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `estimate_items`
--

CREATE TABLE `estimate_items` (
                                  `id` int UNSIGNED NOT NULL,
                                  `estimate_id` int UNSIGNED NOT NULL,
                                  `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `item_summary` text COLLATE utf8mb3_unicode_ci,
                                  `type` enum('item','discount','tax') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'item',
                                  `quantity` double(16,2) NOT NULL,
  `unit_price` double(16,2) NOT NULL,
  `amount` double(16,2) NOT NULL,
  `taxes` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
                          `id` int UNSIGNED NOT NULL,
                          `event_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                          `label_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                          `where` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                          `description` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
                          `start_date_time` datetime NOT NULL,
                          `end_date_time` datetime NOT NULL,
                          `repeat` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                          `repeat_every` int DEFAULT NULL,
                          `repeat_cycles` int DEFAULT NULL,
                          `repeat_type` enum('day','week','month','year') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'day',
                          `send_reminder` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                          `remind_time` int DEFAULT NULL,
                          `remind_type` enum('day','hour','minute') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'day',
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_attendees`
--

CREATE TABLE `event_attendees` (
                                   `id` int UNSIGNED NOT NULL,
                                   `user_id` int UNSIGNED NOT NULL,
                                   `event_id` int UNSIGNED NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
                            `id` int UNSIGNED NOT NULL,
                            `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                            `purchase_date` date NOT NULL,
                            `purchase_from` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `price` double(16,2) NOT NULL,
  `currency_id` int UNSIGNED NOT NULL,
  `project_id` int UNSIGNED DEFAULT NULL,
  `bill` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `can_claim` tinyint(1) NOT NULL DEFAULT '1',
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `expenses_recurring_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` int UNSIGNED DEFAULT NULL,
  `description` text COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses_category`
--

CREATE TABLE `expenses_category` (
                                     `id` bigint UNSIGNED NOT NULL,
                                     `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses_recurring`
--

CREATE TABLE `expenses_recurring` (
                                      `id` bigint UNSIGNED NOT NULL,
                                      `category_id` bigint UNSIGNED DEFAULT NULL,
                                      `currency_id` int UNSIGNED DEFAULT NULL,
                                      `project_id` int UNSIGNED DEFAULT NULL,
                                      `user_id` int UNSIGNED DEFAULT NULL,
                                      `created_by` int UNSIGNED DEFAULT NULL,
                                      `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `day_of_month` int DEFAULT '1',
                                      `day_of_week` int DEFAULT '1',
                                      `payment_method` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                      `rotation` enum('monthly','weekly','bi-weekly','quarterly','half-yearly','annually','daily') COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `billing_cycle` int DEFAULT NULL,
                                      `unlimited_recurring` tinyint(1) NOT NULL DEFAULT '0',
                                      `price` double NOT NULL,
                                      `bill` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                      `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                                      `description` text COLLATE utf8mb3_unicode_ci,
                                      `created_at` timestamp NULL DEFAULT NULL,
                                      `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_storage_settings`
--

CREATE TABLE `file_storage_settings` (
                                         `id` int UNSIGNED NOT NULL,
                                         `filesystem` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `auth_keys` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
                                         `status` enum('enabled','disabled') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disabled',
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `file_storage_settings`
--

INSERT INTO `file_storage_settings` (`id`, `filesystem`, `auth_keys`, `status`, `created_at`, `updated_at`) VALUES
    (1, 'local', NULL, 'enabled', '2023-02-21 05:51:50', '2023-02-21 05:51:50');

-- --------------------------------------------------------

--
-- Table structure for table `gdpr_settings`
--

CREATE TABLE `gdpr_settings` (
                                 `id` int UNSIGNED NOT NULL,
                                 `enable_gdpr` tinyint(1) NOT NULL DEFAULT '0',
                                 `show_customer_area` tinyint(1) NOT NULL DEFAULT '0',
                                 `show_customer_footer` tinyint(1) NOT NULL DEFAULT '0',
                                 `top_information_block` longtext COLLATE utf8mb3_unicode_ci,
                                 `enable_export` tinyint(1) NOT NULL DEFAULT '0',
                                 `data_removal` tinyint(1) NOT NULL DEFAULT '0',
                                 `lead_removal_public_form` tinyint(1) NOT NULL DEFAULT '0',
                                 `terms_customer_footer` tinyint(1) NOT NULL DEFAULT '0',
                                 `terms` longtext COLLATE utf8mb3_unicode_ci,
                                 `policy` longtext COLLATE utf8mb3_unicode_ci,
                                 `public_lead_edit` tinyint(1) NOT NULL DEFAULT '0',
                                 `consent_customer` tinyint(1) NOT NULL DEFAULT '0',
                                 `consent_leads` tinyint(1) NOT NULL DEFAULT '0',
                                 `consent_block` longtext COLLATE utf8mb3_unicode_ci,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `gdpr_settings`
--

INSERT INTO `gdpr_settings` (`id`, `enable_gdpr`, `show_customer_area`, `show_customer_footer`, `top_information_block`, `enable_export`, `data_removal`, `lead_removal_public_form`, `terms_customer_footer`, `terms`, `policy`, `public_lead_edit`, `consent_customer`, `consent_leads`, `consent_block`, `created_at`, `updated_at`) VALUES
    (1, 0, 0, 0, NULL, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, '2023-02-21 05:51:54', '2023-02-21 05:51:54');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
                            `id` int UNSIGNED NOT NULL,
                            `date` date NOT NULL,
                            `occassion` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `created_at` timestamp NULL DEFAULT NULL,
                            `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
                            `id` int UNSIGNED NOT NULL,
                            `project_id` int UNSIGNED DEFAULT NULL,
                            `client_id` int UNSIGNED DEFAULT NULL,
                            `invoice_number` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                            `issue_date` date NOT NULL,
                            `due_date` date NOT NULL,
                            `sub_total` double(16,2) NOT NULL,
  `discount` double NOT NULL DEFAULT '0',
  `discount_type` enum('percent','fixed') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'percent',
  `total` double(16,2) NOT NULL,
  `currency_id` int UNSIGNED DEFAULT NULL,
  `status` enum('paid','unpaid','partial','canceled','draft') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'unpaid',
  `recurring` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
  `billing_cycle` int DEFAULT NULL,
  `billing_interval` int DEFAULT NULL,
  `billing_frequency` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file_original_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  `credit_note` tinyint(1) NOT NULL DEFAULT '0',
  `show_shipping_address` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `estimate_id` int UNSIGNED DEFAULT NULL,
  `send_status` tinyint(1) NOT NULL DEFAULT '1',
  `due_amount` double(8,2) NOT NULL DEFAULT '0.00',
  `parent_id` int UNSIGNED DEFAULT NULL,
  `invoice_recurring_id` bigint UNSIGNED DEFAULT NULL,
  `invoice_refund` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `invoice_refund_id` int DEFAULT NULL,
  `created_by` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
                                 `id` int UNSIGNED NOT NULL,
                                 `invoice_id` int UNSIGNED NOT NULL,
                                 `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `item_summary` text COLLATE utf8mb3_unicode_ci,
                                 `type` enum('item','discount','tax') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'item',
                                 `quantity` double(16,2) NOT NULL,
  `unit_price` double(16,2) NOT NULL,
  `amount` double(16,2) NOT NULL,
  `taxes` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_recurring`
--

CREATE TABLE `invoice_recurring` (
                                     `id` bigint UNSIGNED NOT NULL,
                                     `currency_id` int UNSIGNED DEFAULT NULL,
                                     `project_id` int UNSIGNED DEFAULT NULL,
                                     `client_id` int UNSIGNED DEFAULT NULL,
                                     `user_id` int UNSIGNED DEFAULT NULL,
                                     `created_by` int UNSIGNED DEFAULT NULL,
                                     `issue_date` date NOT NULL,
                                     `due_date` date NOT NULL,
                                     `sub_total` double NOT NULL DEFAULT '0',
                                     `total` double NOT NULL DEFAULT '0',
                                     `discount` double NOT NULL DEFAULT '0',
                                     `discount_type` enum('percent','fixed') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'percent',
                                     `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                                     `file` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                     `file_original_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                     `note` text COLLATE utf8mb3_unicode_ci,
                                     `show_shipping_address` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                     `day_of_month` int DEFAULT '1',
                                     `day_of_week` int DEFAULT '1',
                                     `payment_method` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                     `rotation` enum('monthly','weekly','bi-weekly','quarterly','half-yearly','annually','daily') COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `billing_cycle` int DEFAULT NULL,
                                     `client_can_stop` tinyint(1) NOT NULL DEFAULT '1',
                                     `unlimited_recurring` tinyint(1) NOT NULL DEFAULT '0',
                                     `deleted_at` datetime DEFAULT NULL,
                                     `shipping_address` text COLLATE utf8mb3_unicode_ci,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_recurring_items`
--

CREATE TABLE `invoice_recurring_items` (
                                           `id` int UNSIGNED NOT NULL,
                                           `invoice_recurring_id` bigint UNSIGNED NOT NULL,
                                           `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                           `quantity` double NOT NULL,
                                           `unit_price` double NOT NULL,
                                           `amount` double NOT NULL,
                                           `taxes` text COLLATE utf8mb3_unicode_ci,
                                           `type` enum('item','discount','tax') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'item',
                                           `item_summary` text COLLATE utf8mb3_unicode_ci,
                                           `created_at` timestamp NULL DEFAULT NULL,
                                           `updated_at` timestamp NULL DEFAULT NULL,
                                           `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_settings`
--

CREATE TABLE `invoice_settings` (
                                    `id` int UNSIGNED NOT NULL,
                                    `invoice_prefix` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `invoice_digit` int UNSIGNED NOT NULL DEFAULT '3',
                                    `estimate_prefix` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'EST',
                                    `estimate_digit` int UNSIGNED NOT NULL DEFAULT '3',
                                    `credit_note_prefix` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'CN',
                                    `credit_note_digit` int UNSIGNED NOT NULL DEFAULT '3',
                                    `template` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `due_after` int NOT NULL,
                                    `invoice_terms` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `estimate_terms` text COLLATE utf8mb3_unicode_ci,
                                    `gst_number` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                    `show_gst` enum('yes','no') COLLATE utf8mb3_unicode_ci DEFAULT 'no',
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL,
                                    `logo` varchar(80) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                    `hsn_sac_code_show` tinyint(1) NOT NULL DEFAULT '1',
                                    `locale` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT 'en',
                                    `send_reminder` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `invoice_settings`
--

INSERT INTO `invoice_settings` (`id`, `invoice_prefix`, `invoice_digit`, `estimate_prefix`, `estimate_digit`, `credit_note_prefix`, `credit_note_digit`, `template`, `due_after`, `invoice_terms`, `estimate_terms`, `gst_number`, `show_gst`, `created_at`, `updated_at`, `logo`, `hsn_sac_code_show`, `locale`, `send_reminder`) VALUES
    (1, 'INV', 3, 'EST', 3, 'CN', 3, 'invoice-1', 15, 'Thank you for your business. Please process this invoice within the due date.', NULL, NULL, 'no', '2023-02-21 05:51:48', '2023-02-21 05:51:48', NULL, 1, 'en', 0);

-- --------------------------------------------------------

--
-- Table structure for table `issues`
--

CREATE TABLE `issues` (
                          `id` int UNSIGNED NOT NULL,
                          `description` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
                          `user_id` int UNSIGNED DEFAULT NULL,
                          `project_id` int UNSIGNED DEFAULT NULL,
                          `status` enum('pending','resolved') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `language_settings`
--

CREATE TABLE `language_settings` (
                                     `id` int UNSIGNED NOT NULL,
                                     `language_code` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `language_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `status` enum('enabled','disabled') COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `language_settings`
--

INSERT INTO `language_settings` (`id`, `language_code`, `language_name`, `status`, `created_at`, `updated_at`) VALUES
                                                                                                                   (1, 'ar', 'Arabic', 'disabled', NULL, NULL),
                                                                                                                   (2, 'de', 'German', 'disabled', NULL, NULL),
                                                                                                                   (3, 'es', 'Spanish', 'enabled', NULL, NULL),
                                                                                                                   (4, 'et', 'Estonian', 'disabled', NULL, NULL),
                                                                                                                   (5, 'fa', 'Farsi', 'disabled', NULL, NULL),
                                                                                                                   (6, 'fr', 'French', 'enabled', NULL, NULL),
                                                                                                                   (7, 'gr', 'Greek', 'disabled', NULL, NULL),
                                                                                                                   (8, 'it', 'Italian', 'disabled', NULL, NULL),
                                                                                                                   (9, 'nl', 'Dutch', 'disabled', NULL, NULL),
                                                                                                                   (10, 'pl', 'Polish', 'disabled', NULL, NULL),
                                                                                                                   (11, 'pt', 'Portuguese', 'disabled', NULL, NULL),
                                                                                                                   (12, 'br', 'Portuguese (Brazil)', 'disabled', NULL, NULL),
                                                                                                                   (13, 'ro', 'Romanian', 'disabled', NULL, NULL),
                                                                                                                   (14, 'ru', 'Russian', 'enabled', NULL, NULL),
                                                                                                                   (15, 'tr', 'Turkish', 'disabled', NULL, NULL),
                                                                                                                   (16, 'zh-CN', 'Chinese (S)', 'disabled', NULL, NULL),
                                                                                                                   (17, 'zh-TW', 'Chinese (T)', 'disabled', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
                         `id` int UNSIGNED NOT NULL,
                         `client_id` int DEFAULT NULL,
                         `source_id` int DEFAULT NULL,
                         `status_id` int DEFAULT NULL,
                         `column_priority` int NOT NULL,
                         `agent_id` bigint UNSIGNED DEFAULT NULL,
                         `company_name` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `website` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
                         `client_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `client_email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `mobile` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `cell` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `office` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `city` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `state` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `country` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `postal_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
                         `next_follow_up` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'yes',
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         `value` double DEFAULT '0',
                         `currency_id` int UNSIGNED DEFAULT NULL,
                         `category_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_agents`
--

CREATE TABLE `lead_agents` (
                               `id` bigint UNSIGNED NOT NULL,
                               `user_id` int UNSIGNED NOT NULL,
                               `status` enum('enabled','disabled') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'enabled',
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_category`
--

CREATE TABLE `lead_category` (
                                 `id` int UNSIGNED NOT NULL,
                                 `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_custom_forms`
--

CREATE TABLE `lead_custom_forms` (
                                     `id` bigint UNSIGNED NOT NULL,
                                     `field_display_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `field_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `field_order` int NOT NULL,
                                     `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL,
                                     `required` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `lead_custom_forms`
--

INSERT INTO `lead_custom_forms` (`id`, `field_display_name`, `field_name`, `field_order`, `status`, `created_at`, `updated_at`, `required`) VALUES
                                                                                                                                                (1, 'Name', 'name', 1, 'active', '2023-02-21 05:52:00', '2023-02-21 05:52:01', 1),
                                                                                                                                                (2, 'Email', 'email', 2, 'active', '2023-02-21 05:52:00', '2023-02-21 05:52:01', 1),
                                                                                                                                                (3, 'Company Name', 'company_name', 3, 'active', '2023-02-21 05:52:00', '2023-02-21 05:52:00', 0),
                                                                                                                                                (4, 'Website', 'website', 4, 'active', '2023-02-21 05:52:00', '2023-02-21 05:52:00', 0),
                                                                                                                                                (5, 'Address', 'address', 5, 'active', '2023-02-21 05:52:00', '2023-02-21 05:52:00', 0),
                                                                                                                                                (6, 'Mobile', 'mobile', 6, 'active', '2023-02-21 05:52:00', '2023-02-21 05:52:00', 0),
                                                                                                                                                (7, 'Message', 'message', 7, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 0);

-- --------------------------------------------------------

--
-- Table structure for table `lead_files`
--

CREATE TABLE `lead_files` (
                              `id` int UNSIGNED NOT NULL,
                              `lead_id` int UNSIGNED NOT NULL,
                              `user_id` int UNSIGNED NOT NULL,
                              `filename` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `hashname` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `size` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `description` text COLLATE utf8mb3_unicode_ci,
                              `google_url` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `dropbox_link` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_follow_up`
--

CREATE TABLE `lead_follow_up` (
                                  `id` int UNSIGNED NOT NULL,
                                  `lead_id` int UNSIGNED NOT NULL,
                                  `remark` longtext COLLATE utf8mb3_unicode_ci,
                                  `created_by` int DEFAULT NULL,
                                  `first_call_discussion` text COLLATE utf8mb3_unicode_ci,
                                  `first_call_action` text COLLATE utf8mb3_unicode_ci,
                                  `seconed_call_discussion` text COLLATE utf8mb3_unicode_ci,
                                  `seconed_call_action` text COLLATE utf8mb3_unicode_ci,
                                  `first_meeting_mom` text COLLATE utf8mb3_unicode_ci,
                                  `first_meeting_action` text COLLATE utf8mb3_unicode_ci,
                                  `next_follow_up_date` datetime DEFAULT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_sources`
--

CREATE TABLE `lead_sources` (
                                `id` int UNSIGNED NOT NULL,
                                `type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `lead_sources`
--

INSERT INTO `lead_sources` (`id`, `type`, `created_at`, `updated_at`) VALUES
                                                                          (1, 'email', NULL, NULL),
                                                                          (2, 'google', NULL, NULL),
                                                                          (3, 'facebook', NULL, NULL),
                                                                          (4, 'friend', NULL, NULL),
                                                                          (5, 'direct visit', NULL, NULL),
                                                                          (6, 'tv ad', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lead_status`
--

CREATE TABLE `lead_status` (
                               `id` int UNSIGNED NOT NULL,
                               `type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL,
                               `priority` int NOT NULL,
                               `default` tinyint(1) NOT NULL,
                               `label_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '#ff0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `lead_status`
--

INSERT INTO `lead_status` (`id`, `type`, `created_at`, `updated_at`, `priority`, `default`, `label_color`) VALUES
                                                                                                               (1, 'pending', NULL, '2023-02-21 05:51:58', 1, 1, '#ff0000'),
                                                                                                               (2, 'inprocess', NULL, '2023-02-21 05:51:58', 2, 0, '#ff0000'),
                                                                                                               (3, 'converted', NULL, '2023-02-21 05:51:58', 3, 0, '#ff0000');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
                          `id` int UNSIGNED NOT NULL,
                          `user_id` int UNSIGNED NOT NULL,
                          `leave_type_id` int UNSIGNED NOT NULL,
                          `duration` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                          `leave_date` date NOT NULL,
                          `reason` text COLLATE utf8mb3_unicode_ci NOT NULL,
                          `status` enum('approved','pending','rejected') COLLATE utf8mb3_unicode_ci NOT NULL,
                          `reject_reason` text COLLATE utf8mb3_unicode_ci,
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL,
                          `paid` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_types`
--

CREATE TABLE `leave_types` (
                               `id` int UNSIGNED NOT NULL,
                               `type_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `no_of_leaves` int NOT NULL DEFAULT '5',
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL,
                               `paid` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `leave_types`
--

INSERT INTO `leave_types` (`id`, `type_name`, `color`, `no_of_leaves`, `created_at`, `updated_at`, `paid`) VALUES
                                                                                                               (1, 'Casual', 'success', 5, '2023-02-21 05:51:49', '2023-02-21 05:51:49', 1),
                                                                                                               (2, 'Sick', 'danger', 5, '2023-02-21 05:51:49', '2023-02-21 05:51:49', 1),
                                                                                                               (3, 'Earned', 'info', 5, '2023-02-21 05:51:49', '2023-02-21 05:51:49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `log_time_for`
--

CREATE TABLE `log_time_for` (
                                `id` int UNSIGNED NOT NULL,
                                `log_time_for` enum('project','task') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'project',
                                `auto_timer_stop` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL,
                                `approval_required` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `log_time_for`
--

INSERT INTO `log_time_for` (`id`, `log_time_for`, `auto_timer_stop`, `created_at`, `updated_at`, `approval_required`) VALUES
    (1, 'project', 'no', '2023-02-21 05:51:51', '2023-02-21 05:51:51', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ltm_translations`
--

CREATE TABLE `ltm_translations` (
                                    `id` int UNSIGNED NOT NULL,
                                    `status` int NOT NULL DEFAULT '0',
                                    `locale` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `group` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `key` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `value` text COLLATE utf8mb3_unicode_ci,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
                         `id` bigint UNSIGNED NOT NULL,
                         `menu_name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `translate_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `route` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `module` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `icon` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `setting_menu` tinyint(1) DEFAULT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_name`, `translate_name`, `route`, `module`, `icon`, `setting_menu`, `created_at`, `updated_at`) VALUES
                                                                                                                                     (1, 'dashboard', 'app.menu.dashboard', NULL, 'visibleToAll', 'icon-speedometer', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:58'),
                                                                                                                                     (2, 'customers', 'app.menu.customers', NULL, 'customers', 'icon-people', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (3, 'clients', 'app.menu.clients', 'admin.clients.index', 'clients', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (4, 'leads', 'app.menu.lead', 'admin.leads.index', 'leads', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (5, 'hr', 'app.menu.hr', NULL, 'hr', 'ti-user', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (6, 'employees', 'app.menu.employeeList', 'admin.employees.index', 'employees', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (7, 'department', 'app.department', 'admin.department.index', 'employees', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (8, 'designation', 'app.menu.designation', 'admin.designations.index', 'employees', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (9, 'attendance', 'app.menu.attendance', 'admin.attendances.summary', 'attendance', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (10, 'holidays', 'app.menu.holiday', 'admin.holidays.index', 'holidays', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (11, 'leaves', 'app.menu.leaves', 'admin.leaves.pending', 'leaves', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (12, 'work', 'app.menu.work', NULL, 'work', 'icon-layers', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (13, 'contracts', 'app.menu.contracts', 'admin.contracts.index', 'contracts', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (14, 'projects', 'app.menu.projects', 'admin.projects.index', 'projects', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (15, 'tasks', 'app.menu.tasks', 'admin.all-tasks.index', 'tasks', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (16, 'taskBoard', 'modules.tasks.taskBoard', 'admin.taskboard.index_2', 'tasks', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (17, 'taskCalendar', 'app.menu.taskCalendar', 'admin.task-calendar.index', 'tasks', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (18, 'timelogs', 'app.menu.timeLogs', 'admin.all-time-logs.index', 'timelogs', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (19, 'finance', 'app.menu.finance', NULL, 'finance', 'fa fa-money', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (20, 'estimates', 'app.menu.estimates', 'admin.estimates.index', 'estimates', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (21, 'invoices', 'app.menu.invoices', 'admin.all-invoices.index', 'invoices', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (22, 'payments', 'app.menu.payments', 'admin.payments.index', 'payments', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (23, 'expenses', 'app.menu.expenses', 'admin.expenses.index', 'expenses', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (24, 'credit-note', 'app.menu.credit-note', 'admin.all-credit-notes.index', 'invoices', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (25, 'products', 'app.menu.products', 'admin.products.index', 'products', 'icon-basket', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (26, 'tickets', 'app.menu.tickets', 'admin.tickets.index', 'tickets', 'ti-ticket', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (27, 'messages', 'app.menu.messages', 'admin.user-chat.index', 'messages', 'icon-envelope', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (28, 'events', 'app.menu.Events', 'admin.events.index', 'events', 'icon-calender', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (29, 'noticeBoard', 'app.menu.noticeBoard', 'admin.notices.index', 'notices', 'ti-layout-media-overlay', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (30, 'reports', 'app.menu.reports', NULL, 'visibleToAll', 'ti-pie-chart', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (31, 'taskReport', 'app.menu.taskReport', 'admin.task-report.index', 'visibleToAll', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (32, 'timeLogReport', 'app.menu.timeLogReport', 'admin.time-log-report.index', 'visibleToAll', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (33, 'financeReport', 'app.menu.financeReport', 'admin.finance-report.index', 'visibleToAll', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (34, 'incomeVsExpenseReport', 'app.menu.incomeVsExpenseReport', 'admin.income-expense-report.index', 'visibleToAll', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (35, 'leaveReport', 'app.menu.leaveReport', 'admin.leave-report.index', 'visibleToAll', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (36, 'attendanceReport', 'app.menu.attendanceReport', 'admin.attendance-report.index', 'visibleToAll', NULL, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (37, 'settings', 'app.menu.settings', 'admin.settings.index', 'visibleToAll', 'ti-settings', 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (38, 'accountSettings', 'app.menu.accountSettings', 'admin.settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (39, 'profileSettings', 'app.menu.profileSettings', 'admin.profile-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (40, 'notificationSettings', 'app.menu.notificationSettings', 'admin.email-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (41, 'emailSettings', 'app.menu.emailSettings', 'admin.email-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (42, 'slackSettings', 'app.menu.slackSettings', 'admin.slack-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (43, 'pushNotifications', 'app.menu.pushNotifications', 'admin.push-notification-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (44, 'pusherSettings', 'app.menu.pusherSettings', 'admin.pusher-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (45, 'currencySettings', 'app.menu.currencySettings', 'admin.currency.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (46, 'paymentGatewayCredential', 'app.menu.paymentGatewayCredential', 'admin.payment-gateway-credential.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (47, 'onlinePayment', 'app.menu.onlinePayment', 'admin.payment-gateway-credential.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (48, 'offlinePaymentMethod', 'app.menu.offlinePaymentMethod', 'admin.offline-payment-setting.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (49, 'financeSettings', 'app.menu.financeSettings', 'admin.invoice-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (50, 'ticketSettings', 'app.menu.ticketSettings', 'admin.ticket-agents.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (51, 'ticketAgents', 'app.menu.ticketAgents', 'admin.ticket-agents.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (52, 'ticketTypes', 'app.menu.ticketTypes', 'admin.ticketTypes.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (53, 'ticketChannel', 'app.menu.ticketChannel', 'admin.ticketChannels.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (54, 'replyTemplates', 'app.menu.replyTemplates', 'admin.replyTemplates.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (55, 'projectSettings', 'app.menu.projectSettings', 'admin.project-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (56, 'attendanceSettings', 'app.menu.attendanceSettings', 'admin.attendance-settings.index', 'attendance', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (57, 'leaveSettings', 'app.menu.leaveSettings', 'admin.leaves-settings.index', 'leaves', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (58, 'customFields', 'app.menu.customFields', 'admin.custom-fields.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (59, 'menuSetting', 'app.menu.menuSetting', 'admin.menu-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (60, 'moduleSettings', 'app.menu.moduleSettings', 'admin.module-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (61, 'adminModule', 'app.menu.adminModule', 'admin.module-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (62, 'employeeModule', 'app.menu.employeeModule', 'admin.module-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (63, 'clientModule', 'app.menu.clientModule', 'admin.module-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (64, 'customModule', 'app.menu.customModule', 'admin.custom-modules.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (65, 'rolesPermission', 'app.menu.rolesPermission', 'admin.role-permission.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (66, 'messageSettings', 'app.menu.messageSettings', 'admin.message-settings.index', 'messages', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (67, 'storageSettings', 'app.menu.storageSettings', 'admin.storage-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (68, 'languageSettings', 'app.menu.languageSettings', 'admin.language-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (69, 'leadSettings', 'app.menu.leadSettings', 'admin.lead-source-settings.index', 'leads', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (70, 'leadSource', 'app.menu.leadSource', 'admin.lead-source-settings.index', 'leads', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (71, 'leadStatus', 'app.menu.leadStatus', 'admin.lead-status-settings.index', 'leads', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (72, 'leadAgent', 'modules.lead.leadAgent', 'admin.lead-agent-settings.index', 'leads', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (73, 'timeLogSettings', 'app.menu.timeLogSettings', 'admin.log-time-settings.index', 'timelogs', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (74, 'taskSettings', 'app.menu.taskSettings', 'admin.task-settings.index', 'tasks', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (75, 'gdpr', 'app.menu.gdpr', 'admin.gdpr.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (76, 'general', 'app.menu.general', 'admin.gdpr.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (77, 'rightToDataPortability', 'app.menu.rightToDataPortability', 'admin.gdpr.right-to-data-portability', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (78, 'rightToErasure', 'app.menu.rightToErasure', 'admin.gdpr.right-to-erasure', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (79, 'rightToBeInformed', 'app.menu.rightToBeInformed', 'admin.gdpr.right-to-informed', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (80, 'rightOfRectification', 'app.menu.rightOfRectification', 'admin.gdpr.right-of-access', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (81, 'consent', 'app.menu.consent', 'admin.gdpr.consent', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (82, 'updates', 'app.menu.updates', 'admin.update-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (83, 'themeSettings', 'app.menu.themeSettings', 'admin.theme-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                                                     (84, 'socialAuthSettings', 'app.menu.socialAuthSettings', 'admin.social-auth-settings.index', 'visibleToAll', NULL, 1, '2023-02-21 05:51:57', '2023-02-21 05:51:57'),
                                                                                                                                     (85, 'dashboard', 'app.menu.dashboard', 'admin.dashboard', 'visibleToAll', NULL, 0, '2023-02-21 05:51:58', '2023-02-21 05:51:58'),
                                                                                                                                     (86, 'projectDashboard', 'app.menu.projectDashboard', 'admin.projectDashboard', 'visibleToAll', NULL, 0, '2023-02-21 05:51:58', '2023-02-21 05:51:58'),
                                                                                                                                     (87, 'clientDashboard', 'app.menu.clientDashboard', 'admin.clientDashboard', 'visibleToAll', NULL, 0, '2023-02-21 05:51:58', '2023-02-21 05:51:58'),
                                                                                                                                     (88, 'hrDashboard', 'app.menu.hrDashboard', 'admin.hrDashboard', 'visibleToAll', NULL, 0, '2023-02-21 05:51:58', '2023-02-21 05:51:58'),
                                                                                                                                     (89, 'ticketDashboard', 'app.menu.ticketDashboard', 'admin.ticketDashboard', 'visibleToAll', NULL, 0, '2023-02-21 05:51:58', '2023-02-21 05:51:58'),
                                                                                                                                     (90, 'financeDashboard', 'app.menu.financeDashboard', 'admin.financeDashboard', 'visibleToAll', NULL, 0, '2023-02-21 05:51:58', '2023-02-21 05:51:58');

-- --------------------------------------------------------

--
-- Table structure for table `menu_settings`
--

CREATE TABLE `menu_settings` (
                                 `id` bigint UNSIGNED NOT NULL,
                                 `main_menu` longtext COLLATE utf8mb3_unicode_ci,
                                 `default_main_menu` longtext COLLATE utf8mb3_unicode_ci,
                                 `setting_menu` longtext COLLATE utf8mb3_unicode_ci,
                                 `default_setting_menu` longtext COLLATE utf8mb3_unicode_ci,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `menu_settings`
--

INSERT INTO `menu_settings` (`id`, `main_menu`, `default_main_menu`, `setting_menu`, `default_setting_menu`, `created_at`, `updated_at`) VALUES
    (1, '[{\"id\":1,\"children\":[{\"id\":85},{\"id\":86},{\"id\":87},{\"id\":88},{\"id\":89},{\"id\":90}]},{\"id\":2,\"children\":[{\"id\":3},{\"id\":4}]},{\"id\":5,\"children\":[{\"id\":6},{\"id\":7},{\"id\":8},{\"id\":9},{\"id\":10},{\"id\":11}]},{\"id\":12,\"children\":[{\"id\":13},{\"id\":14},{\"id\":15},{\"id\":16},{\"id\":17},{\"id\":18}]},{\"id\":19,\"children\":[{\"id\":20},{\"id\":21},{\"id\":22},{\"id\":23},{\"id\":24}]},{\"id\":25},{\"id\":26},{\"id\":27},{\"id\":28},{\"id\":29},{\"id\":30,\"children\":[{\"id\":31},{\"id\":32},{\"id\":33},{\"id\":34},{\"id\":35},{\"id\":36}]},{\"id\":37}]', '[{\"id\":1,\"children\":[{\"id\":85},{\"id\":86},{\"id\":87},{\"id\":88},{\"id\":89},{\"id\":90}]},{\"id\":2,\"children\":[{\"id\":3},{\"id\":4}]},{\"id\":5,\"children\":[{\"id\":6},{\"id\":7},{\"id\":8},{\"id\":9},{\"id\":10},{\"id\":11}]},{\"id\":12,\"children\":[{\"id\":13},{\"id\":14},{\"id\":15},{\"id\":16},{\"id\":17},{\"id\":18}]},{\"id\":19,\"children\":[{\"id\":20},{\"id\":21},{\"id\":22},{\"id\":23},{\"id\":24}]},{\"id\":25},{\"id\":26},{\"id\":27},{\"id\":28},{\"id\":29},{\"id\":30,\"children\":[{\"id\":31},{\"id\":32},{\"id\":33},{\"id\":34},{\"id\":35},{\"id\":36}]},{\"id\":37}]', '[{\"id\":38},{\"id\":39},{\"id\":40,\"children\":[{\"id\":41},{\"id\":42},{\"id\":43},{\"id\":44}]},{\"id\":45},{\"id\":46,\"children\":[{\"id\":47},{\"id\":48}]},{\"id\":49},{\"id\":50,\"children\":[{\"id\":51},{\"id\":52},{\"id\":53},{\"id\":54}]},{\"id\":55},{\"id\":56},{\"id\":57},{\"id\":58},{\"id\":59},{\"id\":60,\"children\":[{\"id\":61},{\"id\":62},{\"id\":63},{\"id\":64}]},{\"id\":65},{\"id\":66},{\"id\":67},{\"id\":68},{\"id\":69,\"children\":[{\"id\":70},{\"id\":71},{\"id\":72}]},{\"id\":73},{\"id\":74},{\"id\":75,\"children\":[{\"id\":76},{\"id\":77},{\"id\":78},{\"id\":79},{\"id\":80},{\"id\":81}]},{\"id\":82},{\"id\":83},{\"id\":84}]', '[{\"id\":38},{\"id\":39},{\"id\":40,\"children\":[{\"id\":41},{\"id\":42},{\"id\":43},{\"id\":44}]},{\"id\":45},{\"id\":46,\"children\":[{\"id\":47},{\"id\":48}]},{\"id\":49},{\"id\":50,\"children\":[{\"id\":51},{\"id\":52},{\"id\":53},{\"id\":54}]},{\"id\":55},{\"id\":56},{\"id\":57},{\"id\":58},{\"id\":59},{\"id\":60,\"children\":[{\"id\":61},{\"id\":62},{\"id\":63},{\"id\":64}]},{\"id\":65},{\"id\":66},{\"id\":67},{\"id\":68},{\"id\":69,\"children\":[{\"id\":70},{\"id\":71},{\"id\":72}]},{\"id\":73},{\"id\":74},{\"id\":75,\"children\":[{\"id\":76},{\"id\":77},{\"id\":78},{\"id\":79},{\"id\":80},{\"id\":81}]},{\"id\":82},{\"id\":83},{\"id\":84}]', '2023-02-21 05:51:56', '2023-02-21 05:51:58');

-- --------------------------------------------------------

--
-- Table structure for table `message_settings`
--

CREATE TABLE `message_settings` (
                                    `id` int UNSIGNED NOT NULL,
                                    `allow_client_admin` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                    `allow_client_employee` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `message_settings`
--

INSERT INTO `message_settings` (`id`, `allow_client_admin`, `allow_client_employee`, `created_at`, `updated_at`) VALUES
    (1, 'no', 'no', '2023-02-21 05:51:49', '2023-02-21 05:51:49');

-- --------------------------------------------------------




-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
                           `id` int UNSIGNED NOT NULL,
                           `module_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                           `description` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                           `created_at` timestamp NULL DEFAULT NULL,
                           `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `module_name`, `description`, `created_at`, `updated_at`) VALUES
                                                                                           (1, 'clients', '', NULL, NULL),
                                                                                           (2, 'employees', '', NULL, NULL),
                                                                                           (3, 'projects', 'User can view the basic details of projects assigned to him even without any permission.', NULL, NULL),
                                                                                           (4, 'attendance', 'User can view his own attendance even without any permission.', NULL, NULL),
                                                                                           (5, 'tasks', 'User can view the tasks assigned to him even without any permission.', NULL, NULL),
                                                                                           (6, 'estimates', '', NULL, NULL),
                                                                                           (7, 'invoices', '', NULL, NULL),
                                                                                           (8, 'payments', '', NULL, NULL),
                                                                                           (9, 'timelogs', '', NULL, NULL),
                                                                                           (10, 'tickets', 'User can view the tickets generated by him as default even without any permission.', NULL, NULL),
                                                                                           (11, 'events', 'User can view the events to be attended by him as default even without any permission.', NULL, NULL),
                                                                                           (12, 'notice board', '', NULL, NULL),
                                                                                           (13, 'leaves', 'User can view the leaves applied by him as default even without any permission.', NULL, NULL),
                                                                                           (14, 'leads', NULL, NULL, NULL),
                                                                                           (15, 'holidays', NULL, '2023-02-21 05:51:51', '2023-02-21 05:51:51'),
                                                                                           (16, 'products', NULL, '2023-02-21 05:51:51', '2023-02-21 05:51:51'),
                                                                                           (17, 'expenses', 'User can view and add(self expenses) the expenses as default even without any permission.', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                           (18, 'contracts', 'User can view all contracts', '2023-02-21 05:51:55', '2023-02-21 05:51:55');

-- --------------------------------------------------------

--
-- Table structure for table `module_settings`
--

CREATE TABLE `module_settings` (
                                   `id` int UNSIGNED NOT NULL,
                                   `module_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `status` enum('active','deactive') COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `type` enum('admin','employee','client') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'admin',
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `module_settings`
--

INSERT INTO `module_settings` (`id`, `module_name`, `status`, `type`, `created_at`, `updated_at`) VALUES
                                                                                                      (1, 'clients', 'active', 'admin', NULL, NULL),
                                                                                                      (2, 'employees', 'active', 'admin', NULL, NULL),
                                                                                                      (3, 'attendance', 'active', 'admin', NULL, NULL),
                                                                                                      (4, 'projects', 'active', 'admin', NULL, NULL),
                                                                                                      (5, 'tasks', 'active', 'admin', NULL, NULL),
                                                                                                      (6, 'estimates', 'active', 'admin', NULL, NULL),
                                                                                                      (7, 'invoices', 'active', 'admin', NULL, NULL),
                                                                                                      (8, 'payments', 'active', 'admin', NULL, NULL),
                                                                                                      (9, 'expenses', 'active', 'admin', NULL, NULL),
                                                                                                      (10, 'timelogs', 'active', 'admin', NULL, NULL),
                                                                                                      (11, 'tickets', 'active', 'admin', NULL, NULL),
                                                                                                      (12, 'messages', 'active', 'admin', NULL, NULL),
                                                                                                      (13, 'events', 'active', 'admin', NULL, NULL),
                                                                                                      (14, 'leaves', 'active', 'admin', NULL, NULL),
                                                                                                      (15, 'notices', 'active', 'admin', NULL, NULL),
                                                                                                      (16, 'leads', 'active', 'admin', '2023-02-21 05:51:50', '2023-02-21 05:51:50'),
                                                                                                      (17, 'holidays', 'active', 'admin', '2023-02-21 05:51:51', '2023-02-21 05:51:51'),
                                                                                                      (18, 'products', 'active', 'admin', '2023-02-21 05:51:51', '2023-02-21 05:51:51'),
                                                                                                      (19, 'clients', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (21, 'employees', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (23, 'attendance', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (25, 'projects', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (27, 'tasks', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (29, 'estimates', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (31, 'invoices', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (33, 'payments', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (35, 'expenses', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (37, 'timelogs', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (39, 'tickets', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (41, 'messages', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (43, 'events', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (45, 'leaves', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (47, 'notices', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (49, 'leads', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (51, 'holidays', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (53, 'products', 'active', 'employee', '2023-02-21 05:51:52', '2023-02-21 05:51:52'),
                                                                                                      (65, 'contracts', 'active', 'admin', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (67, 'projects', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (68, 'tickets', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (69, 'invoices', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (70, 'estimates', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (71, 'events', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (72, 'product', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (73, 'messages', 'active', 'client', '2023-02-21 05:51:55', '2023-02-21 05:51:55'),
                                                                                                      (74, 'tasks', 'active', 'client', '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                      (75, 'timelogs', 'active', 'client', '2023-02-21 05:51:56', '2023-02-21 05:51:56'),
                                                                                                      (76, 'contracts', 'active', 'client', '2023-02-21 05:51:57', '2023-02-21 05:51:57'),
                                                                                                      (77, 'notices', 'active', 'client', '2023-02-21 05:51:57', '2023-02-21 05:51:57'),
                                                                                                      (78, 'contracts', 'active', 'employee', '2023-02-21 05:51:57', '2023-02-21 05:51:57'),
                                                                                                      (79, 'expenses', 'active', 'client', '2023-02-21 05:51:58', '2023-02-21 05:51:58'),
                                                                                                      (80, 'payments', 'active', 'client', '2023-02-21 05:51:58', '2023-02-21 05:51:58');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
                           `id` int UNSIGNED NOT NULL,
                           `to` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'employee',
                           `heading` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                           `description` mediumtext COLLATE utf8mb3_unicode_ci,
                           `created_at` timestamp NULL DEFAULT NULL,
                           `updated_at` timestamp NULL DEFAULT NULL,
                           `department_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notice_views`
--

CREATE TABLE `notice_views` (
                                `id` bigint UNSIGNED NOT NULL,
                                `notice_id` int UNSIGNED NOT NULL,
                                `user_id` int UNSIGNED NOT NULL,
                                `read` tinyint(1) NOT NULL DEFAULT '0',
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
                                 `id` char(36) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `notifiable_type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `notifiable_id` bigint UNSIGNED NOT NULL,
                                 `data` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `read_at` timestamp NULL DEFAULT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offline_payment_methods`
--

CREATE TABLE `offline_payment_methods` (
                                           `id` int UNSIGNED NOT NULL,
                                           `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                           `description` longtext COLLATE utf8mb3_unicode_ci,
                                           `status` enum('yes','no') COLLATE utf8mb3_unicode_ci DEFAULT 'yes',
                                           `created_at` timestamp NULL DEFAULT NULL,
                                           `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organisation_settings`
--

CREATE TABLE `organisation_settings` (
                                         `id` int UNSIGNED NOT NULL,
                                         `company_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `company_email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `company_phone` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `logo` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `login_background` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `address` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `website` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `currency_id` int UNSIGNED DEFAULT NULL,
                                         `timezone` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
                                         `date_format` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'd-m-Y',
                                         `date_picker_format` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `time_format` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'h:i a',
                                         `locale` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'en',
                                         `latitude` decimal(10,8) NOT NULL DEFAULT '26.91243360',
                                         `longitude` decimal(11,8) NOT NULL DEFAULT '75.78727090',
                                         `leaves_start_from` enum('joining_date','year_start') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'joining_date',
                                         `active_theme` enum('default','custom') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'default',
                                         `last_updated_by` int UNSIGNED DEFAULT NULL,
                                         `currency_converter_key` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `google_map_key` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `task_self` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'yes',
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL,
                                         `weather_key` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `purchase_code` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `supported_until` timestamp NULL DEFAULT NULL,
                                         `google_recaptcha` tinyint(1) NOT NULL DEFAULT '0',
                                         `google_recaptcha_key` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `google_recaptcha_secret` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `app_debug` tinyint(1) NOT NULL DEFAULT '0',
                                         `rounded_theme` tinyint(1) NOT NULL,
                                         `hide_cron_message` tinyint(1) NOT NULL DEFAULT '0',
                                         `system_update` tinyint(1) NOT NULL DEFAULT '1',
                                         `logo_background_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '#171e28',
                                         `before_days` int NOT NULL,
                                         `after_days` int NOT NULL,
                                         `on_deadline` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'yes',
                                         `default_task_status` int UNSIGNED NOT NULL DEFAULT '1',
                                         `show_review_modal` tinyint(1) NOT NULL DEFAULT '1',
                                         `dashboard_clock` tinyint(1) NOT NULL DEFAULT '1',
                                         `ticket_form_google_captcha` tinyint(1) NOT NULL DEFAULT '0',
                                         `lead_form_google_captcha` tinyint(1) NOT NULL DEFAULT '0',
                                         `last_cron_run` timestamp NULL DEFAULT NULL,
                                         `favicon` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `organisation_settings`
--

INSERT INTO `organisation_settings` (`id`, `company_name`, `company_email`, `company_phone`, `logo`, `login_background`, `address`, `website`, `currency_id`, `timezone`, `date_format`, `date_picker_format`, `time_format`, `locale`, `latitude`, `longitude`, `leaves_start_from`, `active_theme`, `last_updated_by`, `currency_converter_key`, `google_map_key`, `task_self`, `created_at`, `updated_at`, `weather_key`, `purchase_code`, `supported_until`, `google_recaptcha`, `google_recaptcha_key`, `google_recaptcha_secret`, `app_debug`, `rounded_theme`, `hide_cron_message`, `system_update`, `logo_background_color`, `before_days`, `after_days`, `on_deadline`, `default_task_status`, `show_review_modal`, `dashboard_clock`, `ticket_form_google_captcha`, `lead_form_google_captcha`, `last_cron_run`, `favicon`) VALUES
    (1, 'Worksuite', 'company@email.com', '1234567891', NULL, NULL, 'Company address', 'www.domain.com', 1, 'Asia/Kolkata', 'd-m-Y', 'dd-mm-yyyy', 'h:i a', 'en', '26.91243360', '75.78727090', 'joining_date', 'default', NULL, '6c12788708871d0c499d', NULL, 'yes', '2023-02-21 05:52:02', '2023-02-21 05:52:02', '9f7190aeb882036f098ba016003ab300', NULL, NULL, 0, NULL, NULL, 0, 1, 0, 1, '#171e28', 0, 0, 'yes', 1, 1, 1, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
                                   `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `token` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
                            `id` int UNSIGNED NOT NULL,
                            `project_id` int UNSIGNED DEFAULT NULL,
                            `invoice_id` int UNSIGNED DEFAULT NULL,
                            `amount` double NOT NULL,
                            `gateway` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `transaction_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `currency_id` int UNSIGNED DEFAULT NULL,
                            `plan_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `customer_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `event_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `status` enum('complete','pending') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'complete',
                            `paid_on` datetime DEFAULT NULL,
                            `remarks` text COLLATE utf8mb3_unicode_ci,
                            `created_at` timestamp NULL DEFAULT NULL,
                            `updated_at` timestamp NULL DEFAULT NULL,
                            `offline_method_id` int UNSIGNED DEFAULT NULL,
                            `bill` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateway_credentials`
--

CREATE TABLE `payment_gateway_credentials` (
                                               `id` int UNSIGNED NOT NULL,
                                               `paypal_client_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `paypal_secret` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `paypal_status` enum('active','deactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                                               `stripe_client_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `stripe_secret` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `stripe_webhook_secret` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `stripe_status` enum('active','deactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                                               `created_at` timestamp NULL DEFAULT NULL,
                                               `updated_at` timestamp NULL DEFAULT NULL,
                                               `razorpay_key` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `razorpay_secret` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                               `razorpay_status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'inactive',
                                               `paypal_mode` enum('sandbox','live') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'sandbox'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `payment_gateway_credentials`
--

INSERT INTO `payment_gateway_credentials` (`id`, `paypal_client_id`, `paypal_secret`, `paypal_status`, `stripe_client_id`, `stripe_secret`, `stripe_webhook_secret`, `stripe_status`, `created_at`, `updated_at`, `razorpay_key`, `razorpay_secret`, `razorpay_status`, `paypal_mode`) VALUES
    (1, NULL, NULL, 'active', NULL, NULL, NULL, 'active', '2023-02-21 05:51:48', '2023-02-21 05:51:48', NULL, NULL, 'inactive', 'sandbox');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
                               `id` int UNSIGNED NOT NULL,
                               `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                               `display_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                               `description` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                               `module_id` int UNSIGNED NOT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module_id`, `created_at`, `updated_at`) VALUES
                                                                                                                     (1, 'add_clients', 'Add Clients', NULL, 1, NULL, NULL),
                                                                                                                     (2, 'view_clients', 'View Clients', NULL, 1, NULL, NULL),
                                                                                                                     (3, 'edit_clients', 'Edit Clients', NULL, 1, NULL, NULL),
                                                                                                                     (4, 'delete_clients', 'Delete Clients', NULL, 1, NULL, NULL),
                                                                                                                     (5, 'add_employees', 'Add Employees', NULL, 2, NULL, NULL),
                                                                                                                     (6, 'view_employees', 'View Employees', NULL, 2, NULL, NULL),
                                                                                                                     (7, 'edit_employees', 'Edit Employees', NULL, 2, NULL, NULL),
                                                                                                                     (8, 'delete_employees', 'Delete Employees', NULL, 2, NULL, NULL),
                                                                                                                     (9, 'add_projects', 'Add Project', NULL, 3, NULL, NULL),
                                                                                                                     (10, 'view_projects', 'View Project', NULL, 3, NULL, NULL),
                                                                                                                     (11, 'edit_projects', 'Edit Project', NULL, 3, NULL, NULL),
                                                                                                                     (12, 'delete_projects', 'Delete Project', NULL, 3, NULL, NULL),
                                                                                                                     (13, 'add_attendance', 'Add Attendance', NULL, 4, NULL, NULL),
                                                                                                                     (14, 'view_attendance', 'View Attendance', NULL, 4, NULL, NULL),
                                                                                                                     (15, 'add_tasks', 'Add Tasks', NULL, 5, NULL, NULL),
                                                                                                                     (16, 'view_tasks', 'View Tasks', NULL, 5, NULL, NULL),
                                                                                                                     (17, 'edit_tasks', 'Edit Tasks', NULL, 5, NULL, NULL),
                                                                                                                     (18, 'delete_tasks', 'Delete Tasks', NULL, 5, NULL, NULL),
                                                                                                                     (19, 'add_estimates', 'Add Estimates', NULL, 6, NULL, NULL),
                                                                                                                     (20, 'view_estimates', 'View Estimates', NULL, 6, NULL, NULL),
                                                                                                                     (21, 'edit_estimates', 'Edit Estimates', NULL, 6, NULL, NULL),
                                                                                                                     (22, 'delete_estimates', 'Delete Estimates', NULL, 6, NULL, NULL),
                                                                                                                     (23, 'add_invoices', 'Add Invoices', NULL, 7, NULL, NULL),
                                                                                                                     (24, 'view_invoices', 'View Invoices', NULL, 7, NULL, NULL),
                                                                                                                     (25, 'edit_invoices', 'Edit Invoices', NULL, 7, NULL, NULL),
                                                                                                                     (26, 'delete_invoices', 'Delete Invoices', NULL, 7, NULL, NULL),
                                                                                                                     (27, 'add_payments', 'Add Payments', NULL, 8, NULL, NULL),
                                                                                                                     (28, 'view_payments', 'View Payments', NULL, 8, NULL, NULL),
                                                                                                                     (29, 'edit_payments', 'Edit Payments', NULL, 8, NULL, NULL),
                                                                                                                     (30, 'delete_payments', 'Delete Payments', NULL, 8, NULL, NULL),
                                                                                                                     (31, 'add_timelogs', 'Add Timelogs', NULL, 9, NULL, NULL),
                                                                                                                     (32, 'view_timelogs', 'View Timelogs', NULL, 9, NULL, NULL),
                                                                                                                     (33, 'edit_timelogs', 'Edit Timelogs', NULL, 9, NULL, NULL),
                                                                                                                     (34, 'delete_timelogs', 'Delete Timelogs', NULL, 9, NULL, NULL),
                                                                                                                     (35, 'add_tickets', 'Add Tickets', NULL, 10, NULL, NULL),
                                                                                                                     (36, 'view_tickets', 'View Tickets', NULL, 10, NULL, NULL),
                                                                                                                     (37, 'edit_tickets', 'Edit Tickets', NULL, 10, NULL, NULL),
                                                                                                                     (38, 'delete_tickets', 'Delete Tickets', NULL, 10, NULL, NULL),
                                                                                                                     (39, 'add_events', 'Add Events', NULL, 11, NULL, NULL),
                                                                                                                     (40, 'view_events', 'View Events', NULL, 11, NULL, NULL),
                                                                                                                     (41, 'edit_events', 'Edit Events', NULL, 11, NULL, NULL),
                                                                                                                     (42, 'delete_events', 'Delete Events', NULL, 11, NULL, NULL),
                                                                                                                     (43, 'add_notice', 'Add Notice', NULL, 12, NULL, NULL),
                                                                                                                     (44, 'view_notice', 'View Notice', NULL, 12, NULL, NULL),
                                                                                                                     (45, 'edit_notice', 'Edit Notice', NULL, 12, NULL, NULL),
                                                                                                                     (46, 'delete_notice', 'Delete Notice', NULL, 12, NULL, NULL),
                                                                                                                     (47, 'add_leave', 'Add Leave', NULL, 13, NULL, NULL),
                                                                                                                     (48, 'view_leave', 'View Leave', NULL, 13, NULL, NULL),
                                                                                                                     (49, 'edit_leave', 'Edit Leave', NULL, 13, NULL, NULL),
                                                                                                                     (50, 'delete_leave', 'Delete Leave', NULL, 13, NULL, NULL),
                                                                                                                     (51, 'add_lead', 'Add Lead', NULL, 14, NULL, NULL),
                                                                                                                     (52, 'view_lead', 'View Lead', NULL, 14, NULL, NULL),
                                                                                                                     (53, 'edit_lead', 'Edit Lead', NULL, 14, NULL, NULL),
                                                                                                                     (54, 'delete_lead', 'Delete Lead', NULL, 14, NULL, NULL),
                                                                                                                     (55, 'add_holiday', 'Add Holiday', NULL, 15, NULL, NULL),
                                                                                                                     (56, 'view_holiday', 'View Holiday', NULL, 15, NULL, NULL),
                                                                                                                     (57, 'edit_holiday', 'Edit Holiday', NULL, 15, NULL, NULL),
                                                                                                                     (58, 'delete_holiday', 'Delete Holiday', NULL, 15, NULL, NULL),
                                                                                                                     (59, 'add_product', 'Add Product', NULL, 16, NULL, NULL),
                                                                                                                     (60, 'view_product', 'View Product', NULL, 16, NULL, NULL),
                                                                                                                     (61, 'edit_product', 'Edit Product', NULL, 16, NULL, NULL),
                                                                                                                     (62, 'delete_product', 'Delete Product', NULL, 16, NULL, NULL),
                                                                                                                     (63, 'add_expenses', 'Add Expenses', NULL, 17, NULL, NULL),
                                                                                                                     (64, 'view_expenses', 'View Expenses', NULL, 17, NULL, NULL),
                                                                                                                     (65, 'edit_expenses', 'Edit Expenses', NULL, 17, NULL, NULL),
                                                                                                                     (66, 'delete_expenses', 'Delete Expenses', NULL, 17, NULL, NULL),
                                                                                                                     (67, 'add_contract', 'Add Contract', NULL, 18, NULL, NULL),
                                                                                                                     (68, 'view_contract', 'View Contract', NULL, 18, NULL, NULL),
                                                                                                                     (69, 'edit_contract', 'Edit Contract', NULL, 18, NULL, NULL),
                                                                                                                     (70, 'delete_contract', 'Delete Contract', NULL, 18, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
                                   `permission_id` int UNSIGNED NOT NULL,
                                   `role_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pinned`
--

CREATE TABLE `pinned` (
                          `id` bigint UNSIGNED NOT NULL,
                          `project_id` int UNSIGNED DEFAULT NULL,
                          `task_id` int UNSIGNED DEFAULT NULL,
                          `user_id` int UNSIGNED NOT NULL,
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
                            `id` int UNSIGNED NOT NULL,
                            `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                            `price` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                            `taxes` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                            `allow_purchase` tinyint(1) NOT NULL DEFAULT '0',
                            `created_at` timestamp NULL DEFAULT NULL,
                            `updated_at` timestamp NULL DEFAULT NULL,
                            `description` text COLLATE utf8mb3_unicode_ci NOT NULL,
                            `category_id` bigint UNSIGNED DEFAULT NULL,
                            `sub_category_id` bigint UNSIGNED DEFAULT NULL,
                            `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_sub_category`
--

CREATE TABLE `product_sub_category` (
                                        `id` bigint UNSIGNED NOT NULL,
                                        `category_id` bigint UNSIGNED NOT NULL,
                                        `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                        `created_at` timestamp NULL DEFAULT NULL,
                                        `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
                            `id` int UNSIGNED NOT NULL,
                            `project_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                            `project_summary` mediumtext COLLATE utf8mb3_unicode_ci,
                            `project_admin` int UNSIGNED DEFAULT NULL,
                            `start_date` date NOT NULL,
                            `deadline` date DEFAULT NULL,
                            `notes` longtext COLLATE utf8mb3_unicode_ci,
                            `category_id` int UNSIGNED DEFAULT NULL,
                            `client_id` int UNSIGNED DEFAULT NULL,
                            `team_id` int UNSIGNED DEFAULT NULL,
                            `feedback` mediumtext COLLATE utf8mb3_unicode_ci,
                            `manual_timelog` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                            `client_view_task` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                            `allow_client_notification` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                            `completion_percent` tinyint NOT NULL,
                            `calculate_task_progress` enum('true','false') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'true',
                            `created_at` timestamp NULL DEFAULT NULL,
                            `updated_at` timestamp NULL DEFAULT NULL,
                            `deleted_at` timestamp NULL DEFAULT NULL,
                            `project_budget` double(20,2) DEFAULT NULL,
  `currency_id` int UNSIGNED DEFAULT NULL,
  `hours_allocated` double(8,2) DEFAULT NULL,
  `status` enum('not started','in progress','on hold','canceled','finished','under review') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'in progress',
  `visible_rating_employee` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_activity`
--

CREATE TABLE `project_activity` (
                                    `id` int UNSIGNED NOT NULL,
                                    `project_id` int UNSIGNED NOT NULL,
                                    `activity` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_category`
--

CREATE TABLE `project_category` (
                                    `id` int UNSIGNED NOT NULL,
                                    `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_files`
--

CREATE TABLE `project_files` (
                                 `id` int UNSIGNED NOT NULL,
                                 `user_id` int UNSIGNED NOT NULL,
                                 `project_id` int UNSIGNED NOT NULL,
                                 `filename` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `hashname` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                 `size` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                 `description` text COLLATE utf8mb3_unicode_ci,
                                 `google_url` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                 `dropbox_link` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL,
                                 `external_link_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                 `external_link` text COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_members`
--

CREATE TABLE `project_members` (
                                   `id` int UNSIGNED NOT NULL,
                                   `user_id` int UNSIGNED NOT NULL,
                                   `project_id` int UNSIGNED NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL,
                                   `hourly_rate` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_milestones`
--

CREATE TABLE `project_milestones` (
                                      `id` int UNSIGNED NOT NULL,
                                      `project_id` int UNSIGNED DEFAULT NULL,
                                      `currency_id` int UNSIGNED DEFAULT NULL,
                                      `milestone_title` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `summary` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `cost` double(8,2) NOT NULL,
  `status` enum('complete','incomplete') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'incomplete',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `invoice_created` tinyint(1) NOT NULL,
  `invoice_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_ratings`
--

CREATE TABLE `project_ratings` (
                                   `id` bigint UNSIGNED NOT NULL,
                                   `project_id` int UNSIGNED NOT NULL,
                                   `rating` double NOT NULL DEFAULT '0',
                                   `comment` text COLLATE utf8mb3_unicode_ci,
                                   `user_id` int UNSIGNED NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_settings`
--

CREATE TABLE `project_settings` (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `send_reminder` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `remind_time` int NOT NULL,
                                    `remind_type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `remind_to` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '["admins","members"]',
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `project_settings`
--

INSERT INTO `project_settings` (`id`, `send_reminder`, `remind_time`, `remind_type`, `remind_to`, `created_at`, `updated_at`) VALUES
    (1, 'no', 5, 'days', '[\"admins\",\"members\"]', '2023-02-21 05:51:53', '2023-02-21 05:51:53');

-- --------------------------------------------------------

--
-- Table structure for table `project_templates`
--

CREATE TABLE `project_templates` (
                                     `id` int UNSIGNED NOT NULL,
                                     `project_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `category_id` int UNSIGNED DEFAULT NULL,
                                     `client_id` int UNSIGNED DEFAULT NULL,
                                     `project_summary` mediumtext COLLATE utf8mb3_unicode_ci,
                                     `notes` longtext COLLATE utf8mb3_unicode_ci,
                                     `feedback` mediumtext COLLATE utf8mb3_unicode_ci,
                                     `client_view_task` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                     `allow_client_notification` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                     `manual_timelog` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_template_members`
--

CREATE TABLE `project_template_members` (
                                            `id` int UNSIGNED NOT NULL,
                                            `user_id` int UNSIGNED NOT NULL,
                                            `project_template_id` int UNSIGNED NOT NULL,
                                            `created_at` timestamp NULL DEFAULT NULL,
                                            `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_template_sub_tasks`
--

CREATE TABLE `project_template_sub_tasks` (
                                              `id` bigint UNSIGNED NOT NULL,
                                              `project_template_task_id` int UNSIGNED NOT NULL,
                                              `title` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                              `start_date` datetime DEFAULT NULL,
                                              `due_date` datetime DEFAULT NULL,
                                              `status` enum('incomplete','complete') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'incomplete',
                                              `created_at` timestamp NULL DEFAULT NULL,
                                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_template_tasks`
--

CREATE TABLE `project_template_tasks` (
                                          `id` int UNSIGNED NOT NULL,
                                          `heading` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                          `description` mediumtext COLLATE utf8mb3_unicode_ci,
                                          `project_template_id` int UNSIGNED NOT NULL,
                                          `priority` enum('low','medium','high') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'medium',
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          `project_template_task_category_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_template_task_users`
--

CREATE TABLE `project_template_task_users` (
                                               `id` bigint UNSIGNED NOT NULL,
                                               `project_template_task_id` int UNSIGNED NOT NULL,
                                               `user_id` int UNSIGNED NOT NULL,
                                               `created_at` timestamp NULL DEFAULT NULL,
                                               `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_time_logs`
--

CREATE TABLE `project_time_logs` (
                                     `id` int UNSIGNED NOT NULL,
                                     `project_id` int UNSIGNED DEFAULT NULL,
                                     `task_id` int UNSIGNED DEFAULT NULL,
                                     `user_id` int UNSIGNED NOT NULL,
                                     `start_time` datetime NOT NULL,
                                     `end_time` datetime DEFAULT NULL,
                                     `memo` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `total_hours` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                     `total_minutes` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                     `edited_by_user` int UNSIGNED DEFAULT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL,
                                     `hourly_rate` int NOT NULL,
                                     `earnings` int NOT NULL,
                                     `approved` tinyint(1) NOT NULL DEFAULT '1',
                                     `approved_by` int UNSIGNED DEFAULT NULL,
                                     `invoice_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
                             `id` int UNSIGNED NOT NULL,
                             `lead_id` int UNSIGNED NOT NULL,
                             `valid_till` date NOT NULL,
                             `sub_total` double(16,2) NOT NULL,
  `total` double(16,2) NOT NULL,
  `currency_id` int UNSIGNED DEFAULT NULL,
  `discount_type` enum('percent','fixed') COLLATE utf8mb3_unicode_ci NOT NULL,
  `discount` double NOT NULL,
  `invoice_convert` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('declined','accepted','waiting') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'waiting',
  `note` mediumtext COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `client_comment` text COLLATE utf8mb3_unicode_ci,
  `signature_approval` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposal_items`
--

CREATE TABLE `proposal_items` (
                                  `id` int UNSIGNED NOT NULL,
                                  `proposal_id` int UNSIGNED NOT NULL,
                                  `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `type` enum('item','discount','tax') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'item',
                                  `quantity` double(16,2) NOT NULL,
  `unit_price` double(16,2) NOT NULL,
  `amount` double(16,2) NOT NULL,
  `item_summary` text COLLATE utf8mb3_unicode_ci,
  `taxes` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposal_signs`
--

CREATE TABLE `proposal_signs` (
                                  `id` bigint UNSIGNED NOT NULL,
                                  `proposal_id` int UNSIGNED NOT NULL,
                                  `full_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `signature` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purpose_consent`
--

CREATE TABLE `purpose_consent` (
                                   `id` int UNSIGNED NOT NULL,
                                   `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `description` text COLLATE utf8mb3_unicode_ci,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purpose_consent_leads`
--

CREATE TABLE `purpose_consent_leads` (
                                         `id` int UNSIGNED NOT NULL,
                                         `lead_id` int UNSIGNED NOT NULL,
                                         `purpose_consent_id` int UNSIGNED NOT NULL,
                                         `status` enum('agree','disagree') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'agree',
                                         `ip` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `updated_by_id` int UNSIGNED DEFAULT NULL,
                                         `additional_description` text COLLATE utf8mb3_unicode_ci,
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purpose_consent_users`
--

CREATE TABLE `purpose_consent_users` (
                                         `id` int UNSIGNED NOT NULL,
                                         `client_id` int UNSIGNED NOT NULL,
                                         `purpose_consent_id` int UNSIGNED NOT NULL,
                                         `status` enum('agree','disagree') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'agree',
                                         `ip` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                         `updated_by_id` int UNSIGNED NOT NULL,
                                         `additional_description` text COLLATE utf8mb3_unicode_ci,
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pusher_settings`
--

CREATE TABLE `pusher_settings` (
                                   `id` bigint UNSIGNED NOT NULL,
                                   `pusher_app_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `pusher_app_key` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `pusher_app_secret` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `pusher_cluster` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `force_tls` tinyint(1) NOT NULL,
                                   `status` tinyint(1) NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `pusher_settings`
--

INSERT INTO `pusher_settings` (`id`, `pusher_app_id`, `pusher_app_key`, `pusher_app_secret`, `pusher_cluster`, `force_tls`, `status`, `created_at`, `updated_at`) VALUES
    (1, NULL, NULL, NULL, NULL, 0, 0, '2023-02-21 05:51:56', '2023-02-21 05:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `push_notification_settings`
--

CREATE TABLE `push_notification_settings` (
                                              `id` int UNSIGNED NOT NULL,
                                              `onesignal_app_id` text COLLATE utf8mb3_unicode_ci,
                                              `onesignal_rest_api_key` text COLLATE utf8mb3_unicode_ci,
                                              `notification_logo` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                              `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'inactive',
                                              `created_at` timestamp NULL DEFAULT NULL,
                                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `push_notification_settings`
--

INSERT INTO `push_notification_settings` (`id`, `onesignal_app_id`, `onesignal_rest_api_key`, `notification_logo`, `status`, `created_at`, `updated_at`) VALUES
    (1, NULL, NULL, NULL, 'inactive', '2023-02-21 05:51:52', '2023-02-21 05:51:52');

-- --------------------------------------------------------

--
-- Table structure for table `push_subscriptions`
--

CREATE TABLE `push_subscriptions` (
                                      `id` int UNSIGNED NOT NULL,
                                      `user_id` int UNSIGNED NOT NULL,
                                      `endpoint` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                      `public_key` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                      `auth_token` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                      `created_at` timestamp NULL DEFAULT NULL,
                                      `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
                              `id` int UNSIGNED NOT NULL,
                              `business_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `client_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `client_email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `phone` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `address` text COLLATE utf8mb3_unicode_ci,
                              `sub_total` double(8,2) NOT NULL,
  `total` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotation_items`
--

CREATE TABLE `quotation_items` (
                                   `id` int UNSIGNED NOT NULL,
                                   `quotation_id` int UNSIGNED NOT NULL,
                                   `item_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `quantity` int NOT NULL,
                                   `unit_price` int NOT NULL,
                                   `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hsn_sac_code` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `removal_requests`
--

CREATE TABLE `removal_requests` (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `description` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `user_id` int UNSIGNED DEFAULT NULL,
                                    `status` enum('pending','approved','rejected') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `removal_requests_lead`
--

CREATE TABLE `removal_requests_lead` (
                                         `id` bigint UNSIGNED NOT NULL,
                                         `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `description` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `lead_id` int UNSIGNED DEFAULT NULL,
                                         `status` enum('pending','approved','rejected') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
                                         `created_at` timestamp NULL DEFAULT NULL,
                                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
                         `id` int UNSIGNED NOT NULL,
                         `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `display_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `description` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
                                                                                                  (1, 'admin', 'App Administrator', 'Admin is allowed to manage everything of the app.', '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                  (2, 'employee', 'Employee', 'Employee can see tasks and projects assigned to him.', '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                  (3, 'client', 'Client', 'Client can see own tasks and projects.', '2023-02-21 05:52:02', '2023-02-21 05:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
                             `user_id` int UNSIGNED NOT NULL,
                             `role_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
                          `id` int UNSIGNED NOT NULL,
                          `name` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slack_settings`
--

CREATE TABLE `slack_settings` (
                                  `id` int UNSIGNED NOT NULL,
                                  `slack_webhook` text COLLATE utf8mb3_unicode_ci,
                                  `slack_logo` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `slack_settings`
--

INSERT INTO `slack_settings` (`id`, `slack_webhook`, `slack_logo`, `created_at`, `updated_at`) VALUES
    (1, NULL, NULL, '2023-02-21 05:51:48', '2023-02-21 05:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `smtp_settings`
--

CREATE TABLE `smtp_settings` (
                                 `id` int UNSIGNED NOT NULL,
                                 `mail_driver` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'smtp',
                                 `mail_host` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'smtp.gmail.com',
                                 `mail_port` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '587',
                                 `mail_username` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'youremail@gmail.com',
                                 `mail_password` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'your password',
                                 `mail_from_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'your name',
                                 `mail_from_email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'from@email.com',
                                 `mail_encryption` enum('tls','ssl') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'tls',
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL,
                                 `verified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `smtp_settings`
--

INSERT INTO `smtp_settings` (`id`, `mail_driver`, `mail_host`, `mail_port`, `mail_username`, `mail_password`, `mail_from_name`, `mail_from_email`, `mail_encryption`, `created_at`, `updated_at`, `verified`) VALUES
    (1, 'smtp', 'smtp.gmail.com', '465', 'myemail@gmail.com', 'mypassword', 'Worksuite', 'from@email.com', 'ssl', '2023-02-21 05:52:02', '2023-02-21 05:52:02', 0);

-- --------------------------------------------------------

--
-- Table structure for table `socials`
--

CREATE TABLE `socials` (
                           `id` bigint UNSIGNED NOT NULL,
                           `user_id` int UNSIGNED DEFAULT NULL,
                           `social_id` text COLLATE utf8mb3_unicode_ci NOT NULL,
                           `social_service` text COLLATE utf8mb3_unicode_ci NOT NULL,
                           `created_at` timestamp NULL DEFAULT NULL,
                           `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_settings`
--

CREATE TABLE `social_auth_settings` (
                                        `id` bigint UNSIGNED NOT NULL,
                                        `facebook_client_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `facebook_secret_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `facebook_status` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                        `google_client_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `google_secret_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `google_status` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                        `twitter_client_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `twitter_secret_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `twitter_status` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                        `linkedin_client_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `linkedin_secret_id` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                        `linkedin_status` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'disable',
                                        `created_at` timestamp NULL DEFAULT NULL,
                                        `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `social_auth_settings`
--

INSERT INTO `social_auth_settings` (`id`, `facebook_client_id`, `facebook_secret_id`, `facebook_status`, `google_client_id`, `google_secret_id`, `google_status`, `twitter_client_id`, `twitter_secret_id`, `twitter_status`, `linkedin_client_id`, `linkedin_secret_id`, `linkedin_status`, `created_at`, `updated_at`) VALUES
    (1, NULL, NULL, 'disable', NULL, NULL, 'disable', NULL, NULL, 'disable', NULL, NULL, 'disable', '2023-02-21 05:51:57', '2023-02-21 05:51:57');

-- --------------------------------------------------------

--
-- Table structure for table `sticky_notes`
--

CREATE TABLE `sticky_notes` (
                                `id` int UNSIGNED NOT NULL,
                                `user_id` int UNSIGNED NOT NULL,
                                `note_text` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
                                `colour` enum('blue','yellow','red','gray','purple','green') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'blue',
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_tasks`
--

CREATE TABLE `sub_tasks` (
                             `id` int UNSIGNED NOT NULL,
                             `task_id` int UNSIGNED NOT NULL,
                             `title` text COLLATE utf8mb3_unicode_ci NOT NULL,
                             `due_date` datetime DEFAULT NULL,
                             `start_date` date DEFAULT NULL,
                             `status` enum('incomplete','complete') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'incomplete',
                             `created_at` timestamp NULL DEFAULT NULL,
                             `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taskboard_columns`
--

CREATE TABLE `taskboard_columns` (
                                     `id` int UNSIGNED NOT NULL,
                                     `column_name` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `slug` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                     `label_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                     `priority` int NOT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `taskboard_columns`
--

INSERT INTO `taskboard_columns` (`id`, `column_name`, `slug`, `label_color`, `priority`, `created_at`, `updated_at`) VALUES
                                                                                                                         (1, 'Incomplete', 'incomplete', '#d21010', 1, '2023-02-21 05:51:49', '2023-02-21 05:51:52'),
                                                                                                                         (2, 'Completed', 'completed', '#679c0d', 2, '2023-02-21 05:51:50', '2023-02-21 05:51:52');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
                         `id` int UNSIGNED NOT NULL,
                         `heading` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `description` mediumtext COLLATE utf8mb3_unicode_ci,
                         `due_date` date NOT NULL,
                         `start_date` date DEFAULT NULL,
                         `project_id` int UNSIGNED DEFAULT NULL,
                         `task_category_id` int UNSIGNED DEFAULT NULL,
                         `priority` enum('low','medium','high') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'medium',
                         `status` enum('incomplete','completed') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'incomplete',
                         `board_column_id` int UNSIGNED DEFAULT '1',
                         `column_priority` int NOT NULL,
                         `completed_on` datetime DEFAULT NULL,
                         `created_by` int UNSIGNED DEFAULT NULL,
                         `recurring_task_id` int UNSIGNED DEFAULT NULL,
                         `dependent_task_id` int UNSIGNED DEFAULT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         `milestone_id` int UNSIGNED DEFAULT NULL,
                         `is_private` tinyint(1) NOT NULL DEFAULT '1',
                         `billable` tinyint(1) NOT NULL DEFAULT '1',
                         `estimate_hours` int NOT NULL,
                         `estimate_minutes` int NOT NULL,
                         `hash` varchar(64) COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_category`
--

CREATE TABLE `task_category` (
                                 `id` int UNSIGNED NOT NULL,
                                 `category_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_comments`
--

CREATE TABLE `task_comments` (
                                 `id` int UNSIGNED NOT NULL,
                                 `comment` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `user_id` int UNSIGNED NOT NULL,
                                 `task_id` int UNSIGNED NOT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_files`
--

CREATE TABLE `task_files` (
                              `id` int UNSIGNED NOT NULL,
                              `user_id` int UNSIGNED NOT NULL,
                              `task_id` int UNSIGNED NOT NULL,
                              `filename` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `description` text COLLATE utf8mb3_unicode_ci,
                              `google_url` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `hashname` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `size` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `dropbox_link` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `external_link` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `external_link_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_history`
--

CREATE TABLE `task_history` (
                                `id` bigint UNSIGNED NOT NULL,
                                `task_id` int UNSIGNED NOT NULL,
                                `sub_task_id` int UNSIGNED DEFAULT NULL,
                                `user_id` int UNSIGNED NOT NULL,
                                `details` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                `board_column_id` int UNSIGNED DEFAULT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_labels`
--

CREATE TABLE `task_labels` (
                               `id` int UNSIGNED NOT NULL,
                               `label_id` int UNSIGNED NOT NULL,
                               `task_id` int UNSIGNED NOT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_label_list`
--

CREATE TABLE `task_label_list` (
                                   `id` int UNSIGNED NOT NULL,
                                   `label_name` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `color` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `description` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_notes`
--

CREATE TABLE `task_notes` (
                              `id` int UNSIGNED NOT NULL,
                              `task_id` int UNSIGNED NOT NULL,
                              `user_id` int DEFAULT NULL,
                              `note` text COLLATE utf8mb3_unicode_ci,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_users`
--

CREATE TABLE `task_users` (
                              `id` bigint UNSIGNED NOT NULL,
                              `task_id` int UNSIGNED NOT NULL,
                              `user_id` int UNSIGNED NOT NULL,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
                         `id` int UNSIGNED NOT NULL,
                         `tax_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `rate_percent` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
                         `id` int UNSIGNED NOT NULL,
                         `team_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `theme_settings`
--

CREATE TABLE `theme_settings` (
                                  `id` int UNSIGNED NOT NULL,
                                  `panel` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `header_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `sidebar_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `sidebar_text_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                  `link_color` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '#ffffff',
                                  `user_css` longtext COLLATE utf8mb3_unicode_ci,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `theme_settings`
--

INSERT INTO `theme_settings` (`id`, `panel`, `header_color`, `sidebar_color`, `sidebar_text_color`, `link_color`, `user_css`, `created_at`, `updated_at`) VALUES
                                                                                                                                                              (1, 'admin', '#ed4040', '#292929', '#cbcbcb', '#ffffff', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                                                                              (2, 'project_admin', '#5475ed', '#292929', '#cbcbcb', '#ffffff', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                                                                              (3, 'employee', '#f7c80c', '#292929', '#cbcbcb', '#ffffff', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02'),
                                                                                                                                                              (4, 'client', '#00c292', '#292929', '#cbcbcb', '#ffffff', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
                           `id` int UNSIGNED NOT NULL,
                           `user_id` int UNSIGNED NOT NULL,
                           `subject` text COLLATE utf8mb3_unicode_ci NOT NULL,
                           `status` enum('open','pending','resolved','closed') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'open',
                           `priority` enum('low','medium','high','urgent') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'medium',
                           `agent_id` int UNSIGNED DEFAULT NULL,
                           `channel_id` int UNSIGNED DEFAULT NULL,
                           `type_id` int UNSIGNED DEFAULT NULL,
                           `created_at` timestamp NULL DEFAULT NULL,
                           `updated_at` timestamp NULL DEFAULT NULL,
                           `deleted_at` timestamp NULL DEFAULT NULL,
                           `mobile` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                           `country_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_agent_groups`
--

CREATE TABLE `ticket_agent_groups` (
                                       `id` int UNSIGNED NOT NULL,
                                       `agent_id` int UNSIGNED NOT NULL,
                                       `group_id` int UNSIGNED DEFAULT NULL,
                                       `status` enum('enabled','disabled') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'enabled',
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_channels`
--

CREATE TABLE `ticket_channels` (
                                   `id` int UNSIGNED NOT NULL,
                                   `channel_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `ticket_channels`
--

INSERT INTO `ticket_channels` (`id`, `channel_name`, `created_at`, `updated_at`) VALUES
                                                                                     (1, 'Email', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                                     (2, 'Phone', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                                     (3, 'Twitter', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                                     (4, 'Facebook', '2023-02-21 05:51:48', '2023-02-21 05:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_custom_forms`
--

CREATE TABLE `ticket_custom_forms` (
                                       `id` bigint UNSIGNED NOT NULL,
                                       `field_display_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                       `field_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                       `field_type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
                                       `field_order` int NOT NULL,
                                       `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL,
                                       `required` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `ticket_custom_forms`
--

INSERT INTO `ticket_custom_forms` (`id`, `field_display_name`, `field_name`, `field_type`, `field_order`, `status`, `created_at`, `updated_at`, `required`) VALUES
                                                                                                                                                                (1, 'Name', 'name', 'text', 1, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 1),
                                                                                                                                                                (2, 'Email', 'email', 'text', 2, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 1),
                                                                                                                                                                (3, 'Ticket Subject', 'ticket_subject', 'text', 3, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 1),
                                                                                                                                                                (4, 'Message', 'message', 'textarea', 4, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 1),
                                                                                                                                                                (5, 'Type', 'type', 'select', 5, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 0),
                                                                                                                                                                (6, 'Priority', 'priority', 'select', 6, 'active', '2023-02-21 05:52:01', '2023-02-21 05:52:01', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ticket_files`
--

CREATE TABLE `ticket_files` (
                                `id` int UNSIGNED NOT NULL,
                                `user_id` int UNSIGNED NOT NULL,
                                `ticket_reply_id` int UNSIGNED NOT NULL,
                                `filename` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                `description` text COLLATE utf8mb3_unicode_ci,
                                `google_url` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                `hashname` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                `size` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                `dropbox_link` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                `external_link` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                `external_link_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_groups`
--

CREATE TABLE `ticket_groups` (
                                 `id` int UNSIGNED NOT NULL,
                                 `group_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `ticket_groups`
--

INSERT INTO `ticket_groups` (`id`, `group_name`, `created_at`, `updated_at`) VALUES
                                                                                 (1, 'Sales', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                                 (2, 'Code', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                                 (3, 'Management', '2023-02-21 05:51:48', '2023-02-21 05:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_replies`
--

CREATE TABLE `ticket_replies` (
                                  `id` int UNSIGNED NOT NULL,
                                  `ticket_id` int UNSIGNED NOT NULL,
                                  `user_id` int UNSIGNED NOT NULL,
                                  `message` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
                                  `created_at` timestamp NULL DEFAULT NULL,
                                  `updated_at` timestamp NULL DEFAULT NULL,
                                  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_reply_templates`
--

CREATE TABLE `ticket_reply_templates` (
                                          `id` int UNSIGNED NOT NULL,
                                          `reply_heading` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
                                          `reply_text` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_tags`
--

CREATE TABLE `ticket_tags` (
                               `id` int UNSIGNED NOT NULL,
                               `tag_id` int UNSIGNED NOT NULL,
                               `ticket_id` int UNSIGNED NOT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_tag_list`
--

CREATE TABLE `ticket_tag_list` (
                                   `id` int UNSIGNED NOT NULL,
                                   `tag_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_types`
--

CREATE TABLE `ticket_types` (
                                `id` int UNSIGNED NOT NULL,
                                `type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `ticket_types`
--

INSERT INTO `ticket_types` (`id`, `type`, `created_at`, `updated_at`) VALUES
                                                                          (1, 'Question', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                          (2, 'Problem', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                          (3, 'Incident', '2023-02-21 05:51:48', '2023-02-21 05:51:48'),
                                                                          (4, 'Feature Request', '2023-02-21 05:51:48', '2023-02-21 05:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `universal_search`
--

CREATE TABLE `universal_search` (
                                    `id` int UNSIGNED NOT NULL,
                                    `searchable_id` int NOT NULL,
                                    `module_type` enum('ticket','invoice','notice','proposal','task','creditNote','client','employee','project','estimate','lead') COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                                    `title` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `route_name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `universal_search`
--

INSERT INTO `universal_search` (`id`, `searchable_id`, `module_type`, `title`, `route_name`, `created_at`, `updated_at`) VALUES
    (1, 1, NULL, 'Mr. Celestino Daniel V', 'admin.employees.show', '2023-02-21 05:52:02', '2023-02-21 05:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
                         `id` int UNSIGNED NOT NULL,
                         `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `uuid` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `password` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                         `remember_token` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `image` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `mobile` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                         `gender` enum('male','female','others') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'male',
                         `locale` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'en',
                         `status` enum('active','deactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
                         `login` enum('enable','disable') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'enable',
                         `onesignal_player_id` text COLLATE utf8mb3_unicode_ci,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         `last_login` timestamp NULL DEFAULT NULL,
                         `email_notifications` tinyint(1) NOT NULL DEFAULT '1',
                         `country_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `users`
--

-- INSERT INTO `users` (`id`, `name`, `uuid`, `email`, `password`, `remember_token`, `image`, `mobile`, `gender`, `locale`, `status`, `login`, `onesignal_player_id`, `created_at`, `updated_at`, `last_login`, `email_notifications`, `country_id`) VALUES
--     (1, 'super admin', '123456789', 'kero@gmail.com', '$2y$10$EznWbrudLlSqf8ZtNrEMjuGDk5p8WnW7el75aBUH2w/NY4VCmd1KO', NULL, NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2023-02-21 05:52:02', '2023-02-21 05:52:02', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_chat`
--

CREATE TABLE `users_chat` (
                              `id` int UNSIGNED NOT NULL,
                              `user_one` int UNSIGNED NOT NULL,
                              `user_id` int UNSIGNED NOT NULL,
                              `message` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
                              `from` int UNSIGNED DEFAULT NULL,
                              `to` int UNSIGNED DEFAULT NULL,
                              `message_seen` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_activities`
--

CREATE TABLE `user_activities` (
                                   `id` int UNSIGNED NOT NULL,
                                   `user_id` int UNSIGNED NOT NULL,
                                   `activity` text COLLATE utf8mb3_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accept_estimates`
--
ALTER TABLE `accept_estimates`
    ADD PRIMARY KEY (`id`),
  ADD KEY `accept_estimates_estimate_id_foreign` (`estimate_id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
    ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_user_id_foreign` (`user_id`);

--
-- Indexes for table `attendance_settings`
--
ALTER TABLE `attendance_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_categories`
--
ALTER TABLE `client_categories`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_contacts`
--
ALTER TABLE `client_contacts`
    ADD PRIMARY KEY (`id`),
  ADD KEY `client_contacts_user_id_foreign` (`user_id`);

--
-- Indexes for table `client_details`
--
ALTER TABLE `client_details`
    ADD PRIMARY KEY (`id`),
  ADD KEY `client_details_user_id_foreign` (`user_id`),
  ADD KEY `client_details_category_id_foreign` (`category_id`),
  ADD KEY `client_details_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `client_sub_categories`
--
ALTER TABLE `client_sub_categories`
    ADD PRIMARY KEY (`id`),
  ADD KEY `client_sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
    ADD PRIMARY KEY (`id`),
  ADD KEY `contracts_client_id_foreign` (`client_id`),
  ADD KEY `contracts_contract_type_id_foreign` (`contract_type_id`);

--
-- Indexes for table `contract_discussions`
--
ALTER TABLE `contract_discussions`
    ADD PRIMARY KEY (`id`),
  ADD KEY `contract_discussions_contract_id_foreign` (`contract_id`),
  ADD KEY `contract_discussions_from_foreign` (`from`);

--
-- Indexes for table `contract_files`
--
ALTER TABLE `contract_files`
    ADD PRIMARY KEY (`id`),
  ADD KEY `contract_files_user_id_foreign` (`user_id`),
  ADD KEY `contract_files_contract_id_foreign` (`contract_id`);

--
-- Indexes for table `contract_renews`
--
ALTER TABLE `contract_renews`
    ADD PRIMARY KEY (`id`),
  ADD KEY `contract_renews_renewed_by_foreign` (`renewed_by`),
  ADD KEY `contract_renews_contract_id_foreign` (`contract_id`);

--
-- Indexes for table `contract_signs`
--
ALTER TABLE `contract_signs`
    ADD PRIMARY KEY (`id`),
  ADD KEY `contract_signs_contract_id_foreign` (`contract_id`);

--
-- Indexes for table `contract_types`
--
ALTER TABLE `contract_types`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversation`
--
ALTER TABLE `conversation`
    ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_user_one_foreign` (`user_one`),
  ADD KEY `conversation_user_two_foreign` (`user_two`);

--
-- Indexes for table `conversation_reply`
--
ALTER TABLE `conversation_reply`
    ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_reply_conversation_id_foreign` (`conversation_id`),
  ADD KEY `conversation_reply_user_id_foreign` (`user_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `credit_notes`
--
ALTER TABLE `credit_notes`
    ADD PRIMARY KEY (`id`),
  ADD KEY `credit_notes_project_id_foreign` (`project_id`),
  ADD KEY `credit_notes_currency_id_foreign` (`currency_id`),
  ADD KEY `credit_notes_client_id_foreign` (`client_id`);

--
-- Indexes for table `credit_notes_invoice`
--
ALTER TABLE `credit_notes_invoice`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `credit_note_items`
--
ALTER TABLE `credit_note_items`
    ADD PRIMARY KEY (`id`),
  ADD KEY `credit_note_items_credit_note_id_foreign` (`credit_note_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
    ADD PRIMARY KEY (`id`),
  ADD KEY `custom_fields_custom_field_group_id_foreign` (`custom_field_group_id`);

--
-- Indexes for table `custom_fields_data`
--
ALTER TABLE `custom_fields_data`
    ADD PRIMARY KEY (`id`),
  ADD KEY `custom_fields_data_custom_field_id_foreign` (`custom_field_id`),
  ADD KEY `custom_fields_data_model_index` (`model`);

--
-- Indexes for table `custom_field_groups`
--
ALTER TABLE `custom_field_groups`
    ADD PRIMARY KEY (`id`),
  ADD KEY `custom_field_groups_model_index` (`model`);

--
-- Indexes for table `dashboard_widgets`
--
ALTER TABLE `dashboard_widgets`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discussions`
--
ALTER TABLE `discussions`
    ADD PRIMARY KEY (`id`),
  ADD KEY `discussions_discussion_category_id_foreign` (`discussion_category_id`),
  ADD KEY `discussions_project_id_foreign` (`project_id`),
  ADD KEY `discussions_user_id_foreign` (`user_id`),
  ADD KEY `discussions_best_answer_id_foreign` (`best_answer_id`),
  ADD KEY `discussions_last_reply_by_id_foreign` (`last_reply_by_id`);

--
-- Indexes for table `discussion_categories`
--
ALTER TABLE `discussion_categories`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discussion_replies`
--
ALTER TABLE `discussion_replies`
    ADD PRIMARY KEY (`id`),
  ADD KEY `discussion_replies_discussion_id_foreign` (`discussion_id`),
  ADD KEY `discussion_replies_user_id_foreign` (`user_id`);

--
-- Indexes for table `email_notification_settings`
--
ALTER TABLE `email_notification_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_details`
--
ALTER TABLE `employee_details`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_details_slack_username_unique` (`slack_username`),
  ADD UNIQUE KEY `employee_details_employee_id_unique` (`employee_id`),
  ADD KEY `employee_details_user_id_foreign` (`user_id`),
  ADD KEY `employee_details_designation_id_foreign` (`designation_id`),
  ADD KEY `employee_details_department_id_foreign` (`department_id`);

--
-- Indexes for table `employee_docs`
--
ALTER TABLE `employee_docs`
    ADD PRIMARY KEY (`id`),
  ADD KEY `employee_docs_user_id_foreign` (`user_id`);

--
-- Indexes for table `employee_leave_quotas`
--
ALTER TABLE `employee_leave_quotas`
    ADD PRIMARY KEY (`id`),
  ADD KEY `employee_leave_quotas_user_id_foreign` (`user_id`),
  ADD KEY `employee_leave_quotas_leave_type_id_foreign` (`leave_type_id`);

--
-- Indexes for table `employee_skills`
--
ALTER TABLE `employee_skills`
    ADD PRIMARY KEY (`id`),
  ADD KEY `employee_skills_user_id_foreign` (`user_id`),
  ADD KEY `employee_skills_skill_id_foreign` (`skill_id`);

--
-- Indexes for table `employee_teams`
--
ALTER TABLE `employee_teams`
    ADD PRIMARY KEY (`id`),
  ADD KEY `employee_teams_team_id_foreign` (`team_id`),
  ADD KEY `employee_teams_user_id_foreign` (`user_id`);

--
-- Indexes for table `estimates`
--
ALTER TABLE `estimates`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `estimates_estimate_number_unique` (`estimate_number`),
  ADD KEY `estimates_client_id_foreign` (`client_id`),
  ADD KEY `estimates_currency_id_foreign` (`currency_id`);

--
-- Indexes for table `estimate_items`
--
ALTER TABLE `estimate_items`
    ADD PRIMARY KEY (`id`),
  ADD KEY `estimate_items_estimate_id_foreign` (`estimate_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_attendees`
--
ALTER TABLE `event_attendees`
    ADD PRIMARY KEY (`id`),
  ADD KEY `event_attendees_user_id_foreign` (`user_id`),
  ADD KEY `event_attendees_event_id_foreign` (`event_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
    ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_currency_id_foreign` (`currency_id`),
  ADD KEY `expenses_user_id_foreign` (`user_id`),
  ADD KEY `expenses_category_id_foreign` (`category_id`),
  ADD KEY `expenses_expenses_recurring_id_foreign` (`expenses_recurring_id`),
  ADD KEY `expenses_created_by_foreign` (`created_by`);

--
-- Indexes for table `expenses_category`
--
ALTER TABLE `expenses_category`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses_recurring`
--
ALTER TABLE `expenses_recurring`
    ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_recurring_category_id_foreign` (`category_id`),
  ADD KEY `expenses_recurring_currency_id_foreign` (`currency_id`),
  ADD KEY `expenses_recurring_project_id_foreign` (`project_id`),
  ADD KEY `expenses_recurring_user_id_foreign` (`user_id`),
  ADD KEY `expenses_recurring_created_by_foreign` (`created_by`);

--
-- Indexes for table `file_storage_settings`
--
ALTER TABLE `file_storage_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gdpr_settings`
--
ALTER TABLE `gdpr_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoices_invoice_number_unique` (`invoice_number`),
  ADD KEY `invoices_project_id_foreign` (`project_id`),
  ADD KEY `invoices_currency_id_foreign` (`currency_id`),
  ADD KEY `invoices_estimate_id_foreign` (`estimate_id`),
  ADD KEY `invoices_client_id_foreign` (`client_id`),
  ADD KEY `invoices_parent_id_foreign` (`parent_id`),
  ADD KEY `invoices_invoice_recurring_id_foreign` (`invoice_recurring_id`),
  ADD KEY `invoices_created_by_foreign` (`created_by`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
    ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_items_invoice_id_foreign` (`invoice_id`);

--
-- Indexes for table `invoice_recurring`
--
ALTER TABLE `invoice_recurring`
    ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_recurring_currency_id_foreign` (`currency_id`),
  ADD KEY `invoice_recurring_project_id_foreign` (`project_id`),
  ADD KEY `invoice_recurring_client_id_foreign` (`client_id`),
  ADD KEY `invoice_recurring_user_id_foreign` (`user_id`),
  ADD KEY `invoice_recurring_created_by_foreign` (`created_by`);

--
-- Indexes for table `invoice_recurring_items`
--
ALTER TABLE `invoice_recurring_items`
    ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_recurring_items_invoice_recurring_id_foreign` (`invoice_recurring_id`);

--
-- Indexes for table `invoice_settings`
--
ALTER TABLE `invoice_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `issues`
--
ALTER TABLE `issues`
    ADD PRIMARY KEY (`id`),
  ADD KEY `issues_user_id_foreign` (`user_id`),
  ADD KEY `issues_project_id_foreign` (`project_id`);

--
-- Indexes for table `language_settings`
--
ALTER TABLE `language_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
    ADD PRIMARY KEY (`id`),
  ADD KEY `leads_agent_id_foreign` (`agent_id`),
  ADD KEY `leads_currency_id_foreign` (`currency_id`),
  ADD KEY `leads_category_id_foreign` (`category_id`);

--
-- Indexes for table `lead_agents`
--
ALTER TABLE `lead_agents`
    ADD PRIMARY KEY (`id`),
  ADD KEY `lead_agents_user_id_foreign` (`user_id`);

--
-- Indexes for table `lead_category`
--
ALTER TABLE `lead_category`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lead_custom_forms`
--
ALTER TABLE `lead_custom_forms`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lead_files`
--
ALTER TABLE `lead_files`
    ADD PRIMARY KEY (`id`),
  ADD KEY `lead_files_lead_id_foreign` (`lead_id`),
  ADD KEY `lead_files_user_id_foreign` (`user_id`);

--
-- Indexes for table `lead_follow_up`
--
ALTER TABLE `lead_follow_up`
    ADD PRIMARY KEY (`id`),
  ADD KEY `lead_follow_up_lead_id_foreign` (`lead_id`);

--
-- Indexes for table `lead_sources`
--
ALTER TABLE `lead_sources`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lead_sources_type_unique` (`type`);

--
-- Indexes for table `lead_status`
--
ALTER TABLE `lead_status`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lead_status_type_unique` (`type`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
    ADD PRIMARY KEY (`id`),
  ADD KEY `leaves_user_id_foreign` (`user_id`),
  ADD KEY `leaves_leave_type_id_foreign` (`leave_type_id`);

--
-- Indexes for table `leave_types`
--
ALTER TABLE `leave_types`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_time_for`
--
ALTER TABLE `log_time_for`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ltm_translations`
--
ALTER TABLE `ltm_translations`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_settings`
--
ALTER TABLE `menu_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message_settings`
--
ALTER TABLE `message_settings`
    ADD PRIMARY KEY (`id`);


--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module_settings`
--
ALTER TABLE `module_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
    ADD PRIMARY KEY (`id`),
  ADD KEY `notices_department_id_foreign` (`department_id`);

--
-- Indexes for table `notice_views`
--
ALTER TABLE `notice_views`
    ADD PRIMARY KEY (`id`),
  ADD KEY `notice_views_notice_id_foreign` (`notice_id`),
  ADD KEY `notice_views_user_id_foreign` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
    ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `offline_payment_methods`
--
ALTER TABLE `offline_payment_methods`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organisation_settings`
--
ALTER TABLE `organisation_settings`
    ADD PRIMARY KEY (`id`),
  ADD KEY `organisation_settings_last_updated_by_foreign` (`last_updated_by`),
  ADD KEY `organisation_settings_currency_id_foreign` (`currency_id`),
  ADD KEY `organisation_settings_default_task_status_foreign` (`default_task_status`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
    ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_transaction_id_unique` (`transaction_id`),
  ADD UNIQUE KEY `payments_plan_id_unique` (`plan_id`),
  ADD UNIQUE KEY `payments_event_id_unique` (`event_id`),
  ADD KEY `payments_currency_id_foreign` (`currency_id`),
  ADD KEY `payments_project_id_foreign` (`project_id`),
  ADD KEY `payments_invoice_id_foreign` (`invoice_id`),
  ADD KEY `payments_offline_method_id_foreign` (`offline_method_id`);

--
-- Indexes for table `payment_gateway_credentials`
--
ALTER TABLE `payment_gateway_credentials`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`),
  ADD KEY `permissions_module_id_foreign` (`module_id`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
    ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `pinned`
--
ALTER TABLE `pinned`
    ADD PRIMARY KEY (`id`),
  ADD KEY `pinned_project_id_foreign` (`project_id`),
  ADD KEY `pinned_task_id_foreign` (`task_id`),
  ADD KEY `pinned_user_id_foreign` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
    ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
    ADD PRIMARY KEY (`id`),
  ADD KEY `product_sub_category_category_id_foreign` (`category_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
    ADD PRIMARY KEY (`id`),
  ADD KEY `projects_category_id_foreign` (`category_id`),
  ADD KEY `projects_client_id_foreign` (`client_id`),
  ADD KEY `projects_project_admin_foreign` (`project_admin`),
  ADD KEY `projects_currency_id_foreign` (`currency_id`),
  ADD KEY `projects_team_id_foreign` (`team_id`);

--
-- Indexes for table `project_activity`
--
ALTER TABLE `project_activity`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_activity_project_id_foreign` (`project_id`);

--
-- Indexes for table `project_category`
--
ALTER TABLE `project_category`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_files`
--
ALTER TABLE `project_files`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_files_user_id_foreign` (`user_id`),
  ADD KEY `project_files_project_id_foreign` (`project_id`);

--
-- Indexes for table `project_members`
--
ALTER TABLE `project_members`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_members_project_id_foreign` (`project_id`),
  ADD KEY `project_members_user_id_foreign` (`user_id`);

--
-- Indexes for table `project_milestones`
--
ALTER TABLE `project_milestones`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_milestones_project_id_foreign` (`project_id`),
  ADD KEY `project_milestones_currency_id_foreign` (`currency_id`);

--
-- Indexes for table `project_ratings`
--
ALTER TABLE `project_ratings`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_ratings_project_id_foreign` (`project_id`),
  ADD KEY `project_ratings_user_id_foreign` (`user_id`);

--
-- Indexes for table `project_settings`
--
ALTER TABLE `project_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_templates`
--
ALTER TABLE `project_templates`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_templates_category_id_foreign` (`category_id`),
  ADD KEY `project_templates_client_id_foreign` (`client_id`);

--
-- Indexes for table `project_template_members`
--
ALTER TABLE `project_template_members`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_template_members_project_template_id_foreign` (`project_template_id`),
  ADD KEY `project_template_members_user_id_foreign` (`user_id`);

--
-- Indexes for table `project_template_sub_tasks`
--
ALTER TABLE `project_template_sub_tasks`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_template_sub_tasks_project_template_task_id_foreign` (`project_template_task_id`);

--
-- Indexes for table `project_template_tasks`
--
ALTER TABLE `project_template_tasks`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_template_tasks_project_template_id_foreign` (`project_template_id`),
  ADD KEY `project_template_tasks_project_template_task_category_id_foreign` (`project_template_task_category_id`);

--
-- Indexes for table `project_template_task_users`
--
ALTER TABLE `project_template_task_users`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_template_task_users_project_template_task_id_foreign` (`project_template_task_id`),
  ADD KEY `project_template_task_users_user_id_foreign` (`user_id`);

--
-- Indexes for table `project_time_logs`
--
ALTER TABLE `project_time_logs`
    ADD PRIMARY KEY (`id`),
  ADD KEY `project_time_logs_edited_by_user_foreign` (`edited_by_user`),
  ADD KEY `project_time_logs_project_id_foreign` (`project_id`),
  ADD KEY `project_time_logs_user_id_foreign` (`user_id`),
  ADD KEY `project_time_logs_task_id_foreign` (`task_id`),
  ADD KEY `project_time_logs_approved_by_foreign` (`approved_by`),
  ADD KEY `project_time_logs_invoice_id_foreign` (`invoice_id`);

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
    ADD PRIMARY KEY (`id`),
  ADD KEY `proposals_lead_id_foreign` (`lead_id`),
  ADD KEY `proposals_currency_id_foreign` (`currency_id`);

--
-- Indexes for table `proposal_items`
--
ALTER TABLE `proposal_items`
    ADD PRIMARY KEY (`id`),
  ADD KEY `proposal_items_proposal_id_foreign` (`proposal_id`);

--
-- Indexes for table `proposal_signs`
--
ALTER TABLE `proposal_signs`
    ADD PRIMARY KEY (`id`),
  ADD KEY `proposal_signs_proposal_id_foreign` (`proposal_id`);

--
-- Indexes for table `purpose_consent`
--
ALTER TABLE `purpose_consent`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purpose_consent_leads`
--
ALTER TABLE `purpose_consent_leads`
    ADD PRIMARY KEY (`id`),
  ADD KEY `purpose_consent_leads_lead_id_foreign` (`lead_id`),
  ADD KEY `purpose_consent_leads_purpose_consent_id_foreign` (`purpose_consent_id`),
  ADD KEY `purpose_consent_leads_updated_by_id_foreign` (`updated_by_id`);

--
-- Indexes for table `purpose_consent_users`
--
ALTER TABLE `purpose_consent_users`
    ADD PRIMARY KEY (`id`),
  ADD KEY `purpose_consent_users_client_id_foreign` (`client_id`),
  ADD KEY `purpose_consent_users_purpose_consent_id_foreign` (`purpose_consent_id`),
  ADD KEY `purpose_consent_users_updated_by_id_foreign` (`updated_by_id`);

--
-- Indexes for table `pusher_settings`
--
ALTER TABLE `pusher_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `push_notification_settings`
--
ALTER TABLE `push_notification_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`),
  ADD KEY `push_subscriptions_user_id_index` (`user_id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotation_items`
--
ALTER TABLE `quotation_items`
    ADD PRIMARY KEY (`id`),
  ADD KEY `quotation_items_quotation_id_foreign` (`quotation_id`);

--
-- Indexes for table `removal_requests`
--
ALTER TABLE `removal_requests`
    ADD PRIMARY KEY (`id`),
  ADD KEY `removal_requests_user_id_foreign` (`user_id`);

--
-- Indexes for table `removal_requests_lead`
--
ALTER TABLE `removal_requests_lead`
    ADD PRIMARY KEY (`id`),
  ADD KEY `removal_requests_lead_lead_id_foreign` (`lead_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
    ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slack_settings`
--
ALTER TABLE `slack_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtp_settings`
--
ALTER TABLE `smtp_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `socials`
--
ALTER TABLE `socials`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_auth_settings`
--
ALTER TABLE `social_auth_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sticky_notes`
--
ALTER TABLE `sticky_notes`
    ADD PRIMARY KEY (`id`),
  ADD KEY `sticky_notes_user_id_foreign` (`user_id`);

--
-- Indexes for table `sub_tasks`
--
ALTER TABLE `sub_tasks`
    ADD PRIMARY KEY (`id`),
  ADD KEY `sub_tasks_task_id_foreign` (`task_id`);

--
-- Indexes for table `taskboard_columns`
--
ALTER TABLE `taskboard_columns`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taskboard_columns_column_name_unique` (`column_name`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
    ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_project_id_foreign` (`project_id`),
  ADD KEY `tasks_board_column_id_foreign` (`board_column_id`),
  ADD KEY `tasks_created_by_foreign` (`created_by`),
  ADD KEY `tasks_recurring_task_id_foreign` (`recurring_task_id`),
  ADD KEY `tasks_dependent_task_id_foreign` (`dependent_task_id`),
  ADD KEY `tasks_task_category_id_foreign` (`task_category_id`),
  ADD KEY `tasks_milestone_id_foreign` (`milestone_id`);

--
-- Indexes for table `task_category`
--
ALTER TABLE `task_category`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_comments`
--
ALTER TABLE `task_comments`
    ADD PRIMARY KEY (`id`),
  ADD KEY `task_comments_user_id_foreign` (`user_id`),
  ADD KEY `task_comments_task_id_foreign` (`task_id`);

--
-- Indexes for table `task_files`
--
ALTER TABLE `task_files`
    ADD PRIMARY KEY (`id`),
  ADD KEY `task_files_user_id_foreign` (`user_id`),
  ADD KEY `task_files_task_id_foreign` (`task_id`);

--
-- Indexes for table `task_history`
--
ALTER TABLE `task_history`
    ADD PRIMARY KEY (`id`),
  ADD KEY `task_history_task_id_foreign` (`task_id`),
  ADD KEY `task_history_sub_task_id_foreign` (`sub_task_id`),
  ADD KEY `task_history_user_id_foreign` (`user_id`),
  ADD KEY `task_history_board_column_id_foreign` (`board_column_id`);

--
-- Indexes for table `task_labels`
--
ALTER TABLE `task_labels`
    ADD PRIMARY KEY (`id`),
  ADD KEY `task_tags_task_id_foreign` (`task_id`),
  ADD KEY `task_labels_label_id_foreign` (`label_id`);

--
-- Indexes for table `task_label_list`
--
ALTER TABLE `task_label_list`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_notes`
--
ALTER TABLE `task_notes`
    ADD PRIMARY KEY (`id`),
  ADD KEY `task_notes_task_id_foreign` (`task_id`);

--
-- Indexes for table `task_users`
--
ALTER TABLE `task_users`
    ADD PRIMARY KEY (`id`),
  ADD KEY `task_users_task_id_foreign` (`task_id`),
  ADD KEY `task_users_user_id_foreign` (`user_id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `theme_settings`
--
ALTER TABLE `theme_settings`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
    ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_user_id_foreign` (`user_id`),
  ADD KEY `tickets_agent_id_foreign` (`agent_id`),
  ADD KEY `tickets_channel_id_foreign` (`channel_id`),
  ADD KEY `tickets_type_id_foreign` (`type_id`),
  ADD KEY `tickets_country_id_foreign` (`country_id`);

--
-- Indexes for table `ticket_agent_groups`
--
ALTER TABLE `ticket_agent_groups`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_agent_groups_agent_id_foreign` (`agent_id`),
  ADD KEY `ticket_agent_groups_group_id_foreign` (`group_id`);

--
-- Indexes for table `ticket_channels`
--
ALTER TABLE `ticket_channels`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_channels_channel_name_unique` (`channel_name`);

--
-- Indexes for table `ticket_custom_forms`
--
ALTER TABLE `ticket_custom_forms`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_files`
--
ALTER TABLE `ticket_files`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_files_user_id_foreign` (`user_id`),
  ADD KEY `ticket_files_ticket_reply_id_foreign` (`ticket_reply_id`);

--
-- Indexes for table `ticket_groups`
--
ALTER TABLE `ticket_groups`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_replies_ticket_id_foreign` (`ticket_id`),
  ADD KEY `ticket_replies_user_id_foreign` (`user_id`);

--
-- Indexes for table `ticket_reply_templates`
--
ALTER TABLE `ticket_reply_templates`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_tags`
--
ALTER TABLE `ticket_tags`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_tags_tag_id_foreign` (`tag_id`),
  ADD KEY `ticket_tags_ticket_id_foreign` (`ticket_id`);

--
-- Indexes for table `ticket_tag_list`
--
ALTER TABLE `ticket_tag_list`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_types`
--
ALTER TABLE `ticket_types`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_types_type_unique` (`type`);

--
-- Indexes for table `universal_search`
--
ALTER TABLE `universal_search`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_country_id_foreign` (`country_id`);

--
-- Indexes for table `users_chat`
--
ALTER TABLE `users_chat`
    ADD PRIMARY KEY (`id`),
  ADD KEY `users_chat_user_one_foreign` (`user_one`),
  ADD KEY `users_chat_user_id_foreign` (`user_id`),
  ADD KEY `users_chat_from_foreign` (`from`),
  ADD KEY `users_chat_to_foreign` (`to`);

--
-- Indexes for table `user_activities`
--
ALTER TABLE `user_activities`
    ADD PRIMARY KEY (`id`),
  ADD KEY `user_activities_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accept_estimates`
--
ALTER TABLE `accept_estimates`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance_settings`
--
ALTER TABLE `attendance_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `client_categories`
--
ALTER TABLE `client_categories`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_contacts`
--
ALTER TABLE `client_contacts`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_details`
--
ALTER TABLE `client_details`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_sub_categories`
--
ALTER TABLE `client_sub_categories`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_discussions`
--
ALTER TABLE `contract_discussions`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_files`
--
ALTER TABLE `contract_files`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_renews`
--
ALTER TABLE `contract_renews`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_signs`
--
ALTER TABLE `contract_signs`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract_types`
--
ALTER TABLE `contract_types`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversation`
--
ALTER TABLE `conversation`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversation_reply`
--
ALTER TABLE `conversation_reply`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=254;

--
-- AUTO_INCREMENT for table `credit_notes`
--
ALTER TABLE `credit_notes`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credit_notes_invoice`
--
ALTER TABLE `credit_notes_invoice`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credit_note_items`
--
ALTER TABLE `credit_note_items`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_fields_data`
--
ALTER TABLE `custom_fields_data`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_field_groups`
--
ALTER TABLE `custom_field_groups`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `dashboard_widgets`
--
ALTER TABLE `dashboard_widgets`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discussions`
--
ALTER TABLE `discussions`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discussion_categories`
--
ALTER TABLE `discussion_categories`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `discussion_replies`
--
ALTER TABLE `discussion_replies`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_notification_settings`
--
ALTER TABLE `email_notification_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `employee_details`
--
ALTER TABLE `employee_details`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee_docs`
--
ALTER TABLE `employee_docs`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_leave_quotas`
--
ALTER TABLE `employee_leave_quotas`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_skills`
--
ALTER TABLE `employee_skills`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_teams`
--
ALTER TABLE `employee_teams`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estimates`
--
ALTER TABLE `estimates`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estimate_items`
--
ALTER TABLE `estimate_items`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_attendees`
--
ALTER TABLE `event_attendees`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses_category`
--
ALTER TABLE `expenses_category`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses_recurring`
--
ALTER TABLE `expenses_recurring`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_storage_settings`
--
ALTER TABLE `file_storage_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gdpr_settings`
--
ALTER TABLE `gdpr_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_recurring`
--
ALTER TABLE `invoice_recurring`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_recurring_items`
--
ALTER TABLE `invoice_recurring_items`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_settings`
--
ALTER TABLE `invoice_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `issues`
--
ALTER TABLE `issues`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `language_settings`
--
ALTER TABLE `language_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_agents`
--
ALTER TABLE `lead_agents`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_category`
--
ALTER TABLE `lead_category`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_custom_forms`
--
ALTER TABLE `lead_custom_forms`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lead_files`
--
ALTER TABLE `lead_files`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_follow_up`
--
ALTER TABLE `lead_follow_up`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_sources`
--
ALTER TABLE `lead_sources`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lead_status`
--
ALTER TABLE `lead_status`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_types`
--
ALTER TABLE `leave_types`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `log_time_for`
--
ALTER TABLE `log_time_for`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ltm_translations`
--
ALTER TABLE `ltm_translations`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `menu_settings`
--
ALTER TABLE `menu_settings`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `message_settings`
--
ALTER TABLE `message_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;


--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `module_settings`
--
ALTER TABLE `module_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notice_views`
--
ALTER TABLE `notice_views`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offline_payment_methods`
--
ALTER TABLE `offline_payment_methods`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `organisation_settings`
--
ALTER TABLE `organisation_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_gateway_credentials`
--
ALTER TABLE `payment_gateway_credentials`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `pinned`
--
ALTER TABLE `pinned`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_activity`
--
ALTER TABLE `project_activity`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_category`
--
ALTER TABLE `project_category`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_files`
--
ALTER TABLE `project_files`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_members`
--
ALTER TABLE `project_members`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_milestones`
--
ALTER TABLE `project_milestones`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_ratings`
--
ALTER TABLE `project_ratings`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_settings`
--
ALTER TABLE `project_settings`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `project_templates`
--
ALTER TABLE `project_templates`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_template_members`
--
ALTER TABLE `project_template_members`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_template_sub_tasks`
--
ALTER TABLE `project_template_sub_tasks`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_template_tasks`
--
ALTER TABLE `project_template_tasks`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_template_task_users`
--
ALTER TABLE `project_template_task_users`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_time_logs`
--
ALTER TABLE `project_time_logs`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposal_items`
--
ALTER TABLE `proposal_items`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proposal_signs`
--
ALTER TABLE `proposal_signs`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purpose_consent`
--
ALTER TABLE `purpose_consent`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purpose_consent_leads`
--
ALTER TABLE `purpose_consent_leads`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purpose_consent_users`
--
ALTER TABLE `purpose_consent_users`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pusher_settings`
--
ALTER TABLE `pusher_settings`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `push_notification_settings`
--
ALTER TABLE `push_notification_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotation_items`
--
ALTER TABLE `quotation_items`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `removal_requests`
--
ALTER TABLE `removal_requests`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `removal_requests_lead`
--
ALTER TABLE `removal_requests_lead`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slack_settings`
--
ALTER TABLE `slack_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `smtp_settings`
--
ALTER TABLE `smtp_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `socials`
--
ALTER TABLE `socials`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_auth_settings`
--
ALTER TABLE `social_auth_settings`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sticky_notes`
--
ALTER TABLE `sticky_notes`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_tasks`
--
ALTER TABLE `sub_tasks`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taskboard_columns`
--
ALTER TABLE `taskboard_columns`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_category`
--
ALTER TABLE `task_category`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_comments`
--
ALTER TABLE `task_comments`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_files`
--
ALTER TABLE `task_files`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_history`
--
ALTER TABLE `task_history`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_labels`
--
ALTER TABLE `task_labels`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_label_list`
--
ALTER TABLE `task_label_list`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_notes`
--
ALTER TABLE `task_notes`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_users`
--
ALTER TABLE `task_users`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `theme_settings`
--
ALTER TABLE `theme_settings`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_agent_groups`
--
ALTER TABLE `ticket_agent_groups`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_channels`
--
ALTER TABLE `ticket_channels`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket_custom_forms`
--
ALTER TABLE `ticket_custom_forms`
    MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ticket_files`
--
ALTER TABLE `ticket_files`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_groups`
--
ALTER TABLE `ticket_groups`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_reply_templates`
--
ALTER TABLE `ticket_reply_templates`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_tags`
--
ALTER TABLE `ticket_tags`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_tag_list`
--
ALTER TABLE `ticket_tag_list`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_types`
--
ALTER TABLE `ticket_types`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `universal_search`
--
ALTER TABLE `universal_search`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users_chat`
--
ALTER TABLE `users_chat`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_activities`
--
ALTER TABLE `user_activities`
    MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accept_estimates`
--
ALTER TABLE `accept_estimates`
    ADD CONSTRAINT `accept_estimates_estimate_id_foreign` FOREIGN KEY (`estimate_id`) REFERENCES `estimates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
    ADD CONSTRAINT `attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `client_contacts`
--
ALTER TABLE `client_contacts`
    ADD CONSTRAINT `client_contacts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `client_details`
--
ALTER TABLE `client_details`
    ADD CONSTRAINT `client_details_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `client_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `client_details_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `client_sub_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `client_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `client_sub_categories`
--
ALTER TABLE `client_sub_categories`
    ADD CONSTRAINT `client_sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `client_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contracts`
--
ALTER TABLE `contracts`
    ADD CONSTRAINT `contracts_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contracts_contract_type_id_foreign` FOREIGN KEY (`contract_type_id`) REFERENCES `contract_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `contract_discussions`
--
ALTER TABLE `contract_discussions`
    ADD CONSTRAINT `contract_discussions_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contract_discussions_from_foreign` FOREIGN KEY (`from`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contract_files`
--
ALTER TABLE `contract_files`
    ADD CONSTRAINT `contract_files_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contract_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contract_renews`
--
ALTER TABLE `contract_renews`
    ADD CONSTRAINT `contract_renews_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contract_renews_renewed_by_foreign` FOREIGN KEY (`renewed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contract_signs`
--
ALTER TABLE `contract_signs`
    ADD CONSTRAINT `contract_signs_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conversation`
--
ALTER TABLE `conversation`
    ADD CONSTRAINT `conversation_user_one_foreign` FOREIGN KEY (`user_one`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conversation_user_two_foreign` FOREIGN KEY (`user_two`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conversation_reply`
--
ALTER TABLE `conversation_reply`
    ADD CONSTRAINT `conversation_reply_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conversation_reply_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `credit_notes`
--
ALTER TABLE `credit_notes`
    ADD CONSTRAINT `credit_notes_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `credit_notes_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `credit_notes_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `credit_note_items`
--
ALTER TABLE `credit_note_items`
    ADD CONSTRAINT `credit_note_items_credit_note_id_foreign` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_notes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `custom_fields`
--
ALTER TABLE `custom_fields`
    ADD CONSTRAINT `custom_fields_custom_field_group_id_foreign` FOREIGN KEY (`custom_field_group_id`) REFERENCES `custom_field_groups` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `custom_fields_data`
--
ALTER TABLE `custom_fields_data`
    ADD CONSTRAINT `custom_fields_data_custom_field_id_foreign` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `discussions`
--
ALTER TABLE `discussions`
    ADD CONSTRAINT `discussions_best_answer_id_foreign` FOREIGN KEY (`best_answer_id`) REFERENCES `discussion_replies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `discussions_discussion_category_id_foreign` FOREIGN KEY (`discussion_category_id`) REFERENCES `discussion_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `discussions_last_reply_by_id_foreign` FOREIGN KEY (`last_reply_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `discussions_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `discussion_replies`
--
ALTER TABLE `discussion_replies`
    ADD CONSTRAINT `discussion_replies_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `discussion_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_details`
--
ALTER TABLE `employee_details`
    ADD CONSTRAINT `employee_details_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `teams` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_details_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_docs`
--
ALTER TABLE `employee_docs`
    ADD CONSTRAINT `employee_docs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_leave_quotas`
--
ALTER TABLE `employee_leave_quotas`
    ADD CONSTRAINT `employee_leave_quotas_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_leave_quotas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_skills`
--
ALTER TABLE `employee_skills`
    ADD CONSTRAINT `employee_skills_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_skills_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_teams`
--
ALTER TABLE `employee_teams`
    ADD CONSTRAINT `employee_teams_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_teams_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `estimates`
--
ALTER TABLE `estimates`
    ADD CONSTRAINT `estimates_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `estimates_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `estimate_items`
--
ALTER TABLE `estimate_items`
    ADD CONSTRAINT `estimate_items_estimate_id_foreign` FOREIGN KEY (`estimate_id`) REFERENCES `estimates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event_attendees`
--
ALTER TABLE `event_attendees`
    ADD CONSTRAINT `event_attendees_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `event_attendees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
    ADD CONSTRAINT `expenses_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `expenses_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
                                                                                                                                                                                                                                                                  ADD CONSTRAINT `expenses_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_expenses_recurring_id_foreign` FOREIGN KEY (`expenses_recurring_id`) REFERENCES `expenses_recurring` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `expenses_recurring`
--
ALTER TABLE `expenses_recurring`
    ADD CONSTRAINT `expenses_recurring_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `expenses_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_recurring_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
                                                                                                                                                                                                                                                                                      ADD CONSTRAINT `expenses_recurring_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_recurring_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_recurring_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
    ADD CONSTRAINT `invoices_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
                                                                                                                                                                                                                                                  ADD CONSTRAINT `invoices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_estimate_id_foreign` FOREIGN KEY (`estimate_id`) REFERENCES `estimates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_invoice_recurring_id_foreign` FOREIGN KEY (`invoice_recurring_id`) REFERENCES `invoice_recurring` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
    ADD CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_recurring`
--
ALTER TABLE `invoice_recurring`
    ADD CONSTRAINT `invoice_recurring_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_recurring_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
                                                                                                                                                                                                                                                                    ADD CONSTRAINT `invoice_recurring_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_recurring_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_recurring_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice_recurring_items`
--
ALTER TABLE `invoice_recurring_items`
    ADD CONSTRAINT `invoice_recurring_items_invoice_recurring_id_foreign` FOREIGN KEY (`invoice_recurring_id`) REFERENCES `invoice_recurring` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `issues`
--
ALTER TABLE `issues`
    ADD CONSTRAINT `issues_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `issues_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `leads`
--
ALTER TABLE `leads`
    ADD CONSTRAINT `leads_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `lead_agents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leads_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `lead_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `leads_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `lead_agents`
--
ALTER TABLE `lead_agents`
    ADD CONSTRAINT `lead_agents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lead_files`
--
ALTER TABLE `lead_files`
    ADD CONSTRAINT `lead_files_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lead_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lead_follow_up`
--
ALTER TABLE `lead_follow_up`
    ADD CONSTRAINT `lead_follow_up_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `leaves`
--
ALTER TABLE `leaves`
    ADD CONSTRAINT `leaves_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leaves_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notices`
--
ALTER TABLE `notices`
    ADD CONSTRAINT `notices_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notice_views`
--
ALTER TABLE `notice_views`
    ADD CONSTRAINT `notice_views_notice_id_foreign` FOREIGN KEY (`notice_id`) REFERENCES `notices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notice_views_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `organisation_settings`
--
ALTER TABLE `organisation_settings`
    ADD CONSTRAINT `organisation_settings_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `organisation_settings_default_task_status_foreign` FOREIGN KEY (`default_task_status`) REFERENCES `taskboard_columns` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `organisation_settings_last_updated_by_foreign` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
    ADD CONSTRAINT `payments_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_offline_method_id_foreign` FOREIGN KEY (`offline_method_id`) REFERENCES `offline_payment_methods` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
    ADD CONSTRAINT `permissions_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
    ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pinned`
--
ALTER TABLE `pinned`
    ADD CONSTRAINT `pinned_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pinned_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pinned_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
    ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `product_sub_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
    ADD CONSTRAINT `product_sub_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
    ADD CONSTRAINT `projects_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `project_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_project_admin_foreign` FOREIGN KEY (`project_admin`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `project_activity`
--
ALTER TABLE `project_activity`
    ADD CONSTRAINT `project_activity_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_files`
--
ALTER TABLE `project_files`
    ADD CONSTRAINT `project_files_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_members`
--
ALTER TABLE `project_members`
    ADD CONSTRAINT `project_members_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_milestones`
--
ALTER TABLE `project_milestones`
    ADD CONSTRAINT `project_milestones_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_milestones_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_ratings`
--
ALTER TABLE `project_ratings`
    ADD CONSTRAINT `project_ratings_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_templates`
--
ALTER TABLE `project_templates`
    ADD CONSTRAINT `project_templates_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `project_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `project_templates_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `project_template_members`
--
ALTER TABLE `project_template_members`
    ADD CONSTRAINT `project_template_members_project_template_id_foreign` FOREIGN KEY (`project_template_id`) REFERENCES `project_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_template_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_template_sub_tasks`
--
ALTER TABLE `project_template_sub_tasks`
    ADD CONSTRAINT `project_template_sub_tasks_project_template_task_id_foreign` FOREIGN KEY (`project_template_task_id`) REFERENCES `project_template_tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_template_tasks`
--
ALTER TABLE `project_template_tasks`
    ADD CONSTRAINT `project_template_tasks_project_template_id_foreign` FOREIGN KEY (`project_template_id`) REFERENCES `project_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_template_tasks_project_template_task_category_id_foreign` FOREIGN KEY (`project_template_task_category_id`) REFERENCES `task_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `project_template_task_users`
--
ALTER TABLE `project_template_task_users`
    ADD CONSTRAINT `project_template_task_users_project_template_task_id_foreign` FOREIGN KEY (`project_template_task_id`) REFERENCES `project_template_tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_template_task_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_time_logs`
--
ALTER TABLE `project_time_logs`
    ADD CONSTRAINT `project_time_logs_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `project_time_logs_edited_by_user_foreign` FOREIGN KEY (`edited_by_user`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `project_time_logs_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `project_time_logs_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_time_logs_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_time_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proposals`
--
ALTER TABLE `proposals`
    ADD CONSTRAINT `proposals_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `proposals_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proposal_items`
--
ALTER TABLE `proposal_items`
    ADD CONSTRAINT `proposal_items_proposal_id_foreign` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proposal_signs`
--
ALTER TABLE `proposal_signs`
    ADD CONSTRAINT `proposal_signs_proposal_id_foreign` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purpose_consent_leads`
--
ALTER TABLE `purpose_consent_leads`
    ADD CONSTRAINT `purpose_consent_leads_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purpose_consent_leads_purpose_consent_id_foreign` FOREIGN KEY (`purpose_consent_id`) REFERENCES `purpose_consent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purpose_consent_leads_updated_by_id_foreign` FOREIGN KEY (`updated_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purpose_consent_users`
--
ALTER TABLE `purpose_consent_users`
    ADD CONSTRAINT `purpose_consent_users_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purpose_consent_users_purpose_consent_id_foreign` FOREIGN KEY (`purpose_consent_id`) REFERENCES `purpose_consent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `purpose_consent_users_updated_by_id_foreign` FOREIGN KEY (`updated_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
    ADD CONSTRAINT `push_subscriptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quotation_items`
--
ALTER TABLE `quotation_items`
    ADD CONSTRAINT `quotation_items_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `removal_requests`
--
ALTER TABLE `removal_requests`
    ADD CONSTRAINT `removal_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `removal_requests_lead`
--
ALTER TABLE `removal_requests_lead`
    ADD CONSTRAINT `removal_requests_lead_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
    ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sticky_notes`
--
ALTER TABLE `sticky_notes`
    ADD CONSTRAINT `sticky_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_tasks`
--
ALTER TABLE `sub_tasks`
    ADD CONSTRAINT `sub_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
    ADD CONSTRAINT `tasks_board_column_id_foreign` FOREIGN KEY (`board_column_id`) REFERENCES `taskboard_columns` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_dependent_task_id_foreign` FOREIGN KEY (`dependent_task_id`) REFERENCES `tasks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_milestone_id_foreign` FOREIGN KEY (`milestone_id`) REFERENCES `project_milestones` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_recurring_task_id_foreign` FOREIGN KEY (`recurring_task_id`) REFERENCES `tasks` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tasks_task_category_id_foreign` FOREIGN KEY (`task_category_id`) REFERENCES `task_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `task_comments`
--
ALTER TABLE `task_comments`
    ADD CONSTRAINT `task_comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_files`
--
ALTER TABLE `task_files`
    ADD CONSTRAINT `task_files_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_history`
--
ALTER TABLE `task_history`
    ADD CONSTRAINT `task_history_board_column_id_foreign` FOREIGN KEY (`board_column_id`) REFERENCES `taskboard_columns` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `task_history_sub_task_id_foreign` FOREIGN KEY (`sub_task_id`) REFERENCES `sub_tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_history_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_history_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_labels`
--
ALTER TABLE `task_labels`
    ADD CONSTRAINT `task_labels_label_id_foreign` FOREIGN KEY (`label_id`) REFERENCES `task_label_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_tags_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_notes`
--
ALTER TABLE `task_notes`
    ADD CONSTRAINT `task_notes_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_users`
--
ALTER TABLE `task_users`
    ADD CONSTRAINT `task_users_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
    ADD CONSTRAINT `tickets_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `ticket_channels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `ticket_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_agent_groups`
--
ALTER TABLE `ticket_agent_groups`
    ADD CONSTRAINT `ticket_agent_groups_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_agent_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `ticket_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_files`
--
ALTER TABLE `ticket_files`
    ADD CONSTRAINT `ticket_files_ticket_reply_id_foreign` FOREIGN KEY (`ticket_reply_id`) REFERENCES `ticket_replies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
    ADD CONSTRAINT `ticket_replies_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_tags`
--
ALTER TABLE `ticket_tags`
    ADD CONSTRAINT `ticket_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `ticket_tag_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_tags_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
    ADD CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users_chat`
--
ALTER TABLE `users_chat`
    ADD CONSTRAINT `users_chat_from_foreign` FOREIGN KEY (`from`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_chat_to_foreign` FOREIGN KEY (`to`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_chat_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_chat_user_one_foreign` FOREIGN KEY (`user_one`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_activities`
--
ALTER TABLE `user_activities`
    ADD CONSTRAINT `user_activities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `taskboard_columns` ADD `deleted_at` TIMESTAMP NULL DEFAULT NULL AFTER `updated_at`;

COMMIT;