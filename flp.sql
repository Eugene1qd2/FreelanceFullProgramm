-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 29 2023 г., 17:34
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `freelanceplatformdb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ads`
--

CREATE TABLE `ads` (
  `ID_ad` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL,
  `Topic` varchar(100) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Workplace` varchar(50) NOT NULL,
  `Address` varchar(256) DEFAULT NULL,
  `Budget` double UNSIGNED NOT NULL,
  `Nonreldate` date NOT NULL,
  `Lessoncount` int(10) UNSIGNED DEFAULT NULL,
  `Goal` text NOT NULL,
  `Isaccepted` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `ads_skills`
--

CREATE TABLE `ads_skills` (
  `ID_skill` int(10) UNSIGNED NOT NULL,
  `ID_ad` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chats`
--

CREATE TABLE `chats` (
  `ID_chat` int(10) UNSIGNED NOT NULL,
  `Topic` varchar(100) NOT NULL,
  `Creationdate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chat_members`
--

CREATE TABLE `chat_members` (
  `ID_chat` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `educations`
--

CREATE TABLE `educations` (
  `ID_education` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL,
  `Institution` varchar(256) NOT NULL,
  `Startyear` int(11) NOT NULL,
  `Endyear` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `ID_message` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL,
  `ID_chat` int(10) UNSIGNED NOT NULL,
  `Senddate` datetime NOT NULL DEFAULT current_timestamp(),
  `Text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `responses`
--

CREATE TABLE `responses` (
  `ID_ad` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL,
  `Isaccepted` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `ID_profile` int(11) UNSIGNED NOT NULL,
  `ID_user` int(11) UNSIGNED NOT NULL,
  `Senddate` datetime NOT NULL DEFAULT current_timestamp(),
  `Text` text DEFAULT NULL,
  `Rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `skills`
--

CREATE TABLE `skills` (
  `ID_skill` int(11) UNSIGNED NOT NULL,
  `Skill` varchar(50) NOT NULL,
  `Discription` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `skills`
--

INSERT INTO `skills` (`ID_skill`, `Skill`, `Discription`) VALUES
(1, 'Спидкубинг', 'Скоростная сборка кубика-рубика.'),
(2, 'Пенспининг', 'Кручение ручки в руке.'),
(3, 'Сборка компьютеров', 'Профессиональная сборка персональных компьютеров.'),
(4, 'Рисование карандашом', 'Рисование карандашом.'),
(5, 'Игра на гитаре', 'Игра на гитаре.'),
(6, 'Готовка на гриле', 'Готовка на гриле.'),
(7, 'Игра на треугольнике', 'Игра на треугольнике.'),
(8, 'Игра на пианино', 'Игра на пианино и фортепиано.'),
(9, 'Написание сценариев', 'Профессиональное написание остросюжетных сценариев.'),
(10, 'Выжигание по дереву', 'Выжигание по дереву.'),
(11, 'Создание изделий из эпоксидной смолы', 'Создание изделий из эпоксидной смолы.'),
(12, 'Пошив одежды', 'Пошив одежды на заказ.'),
(13, 'С#', 'Знание C#'),
(14, 'C++', 'Знание C++'),
(15, 'Python', 'Знание Python.'),
(16, 'JavaScript', 'Знание JavaScript.'),
(17, 'Вокал', 'Профессиональное пение'),
(18, 'Пение', 'Профессиональное пение'),
(19, 'Ремонт компьютеров', 'Ремонт компьютеров'),
(20, '2D Дизайн', 'Дизайн двухмерных форм и др.'),
(21, '3D Дизайн', 'Дизайн трёхмерных объектов и др.'),
(22, 'WPF', 'Знание Windows Presentation Foundation '),
(23, 'ASP .NET', 'Знание ASP .NET'),
(24, '.NET Framework', 'Знание .NET Framework'),
(25, 'Написание музыки', 'Написание музыки'),
(26, 'Bootstrap', 'Знание Bootstrap'),
(27, 'React', 'Знание React'),
(28, 'Lua', 'Знание Lua'),
(29, 'Ораторское искусство', 'Профессиональное ораторское искусство'),
(30, 'Метание карт', 'Метание карт'),
(31, 'Цветоводство', 'Цветоводство'),
(32, 'Психология', 'Профессиональный психолог'),
(33, 'Игра в шахматы', 'Достойный игрок в шахматы'),
(34, 'Скорочтение', 'Профессиональное скорочтение'),
(35, 'Сноубординг', 'Катание на сноуборде'),
(36, 'Йога', 'Профессиональный Йог'),
(37, 'Плавание', 'Умение плавать'),
(38, 'Web-дизайн', 'Web-дизайнер'),
(39, 'Game-дизайн', 'Game-дизайнер'),
(40, 'Adobe Photoshop', 'Знание Adobe Photoshop'),
(41, 'Adobe Illustrator', 'Знание Adobe Illustrator'),
(42, 'Adobe AfterEffects', 'Знание Adobe AfterEffects'),
(43, 'Adobe PremierPro', 'Знание Adobe PremierPro'),
(44, 'Git', 'Знание Git'),
(45, 'Git Hub', 'Знание Git Hub'),
(46, 'Git Lab', 'Знание Git Lab'),
(47, 'Blender', 'Знание Blender'),
(48, '3ds MAX', 'Знание 3ds MAX');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Middlename` varchar(20) NOT NULL,
  `Birthday` date NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Registerdate` date NOT NULL DEFAULT current_timestamp(),
  `Male` varchar(50) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Aboutme` text DEFAULT NULL,
  `Photo` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_skills`
--

CREATE TABLE `user_skills` (
  `ID_skill` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `workexps`
--

CREATE TABLE `workexps` (
  `ID_workexp` int(10) UNSIGNED NOT NULL,
  `ID_user` int(10) UNSIGNED NOT NULL,
  `Company` varchar(256) NOT NULL,
  `Post` varchar(256) NOT NULL,
  `Duration` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `сertificates`
--

CREATE TABLE `сertificates` (
  `ID_сertificate` int(11) UNSIGNED NOT NULL,
  `ID_user` int(11) UNSIGNED NOT NULL,
  `Organization` text NOT NULL,
  `Skill` varchar(256) NOT NULL,
  `Link` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`ID_ad`),
  ADD KEY `ID_user` (`ID_user`);

--
-- Индексы таблицы `ads_skills`
--
ALTER TABLE `ads_skills`
  ADD KEY `ID_skill` (`ID_skill`),
  ADD KEY `ID_ad` (`ID_ad`);

--
-- Индексы таблицы `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`ID_chat`);

--
-- Индексы таблицы `chat_members`
--
ALTER TABLE `chat_members`
  ADD KEY `ID_chat` (`ID_chat`),
  ADD KEY `ID_user` (`ID_user`);

--
-- Индексы таблицы `educations`
--
ALTER TABLE `educations`
  ADD PRIMARY KEY (`ID_education`),
  ADD KEY `ID_user` (`ID_user`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`ID_message`),
  ADD KEY `ID_user` (`ID_user`),
  ADD KEY `ID_chat` (`ID_chat`);

--
-- Индексы таблицы `responses`
--
ALTER TABLE `responses`
  ADD KEY `ID_user` (`ID_user`),
  ADD KEY `ID_ad` (`ID_ad`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD KEY `INDEX` (`ID_profile`),
  ADD KEY `INDEX_USER` (`ID_user`);

--
-- Индексы таблицы `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`ID_skill`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `user_skills`
--
ALTER TABLE `user_skills`
  ADD KEY `ID_skill` (`ID_skill`,`ID_user`),
  ADD KEY `ID_user` (`ID_user`);

--
-- Индексы таблицы `workexps`
--
ALTER TABLE `workexps`
  ADD PRIMARY KEY (`ID_workexp`),
  ADD KEY `ID_user` (`ID_user`);

--
-- Индексы таблицы `сertificates`
--
ALTER TABLE `сertificates`
  ADD PRIMARY KEY (`ID_сertificate`),
  ADD KEY `ID_user` (`ID_user`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ads`
--
ALTER TABLE `ads`
  MODIFY `ID_ad` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `chats`
--
ALTER TABLE `chats`
  MODIFY `ID_chat` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `educations`
--
ALTER TABLE `educations`
  MODIFY `ID_education` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `ID_message` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `workexps`
--
ALTER TABLE `workexps`
  MODIFY `ID_workexp` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `сertificates`
--
ALTER TABLE `сertificates`
  MODIFY `ID_сertificate` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `ads`
--
ALTER TABLE `ads`
  ADD CONSTRAINT `ads_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ads_skills`
--
ALTER TABLE `ads_skills`
  ADD CONSTRAINT `ads_skills_ibfk_1` FOREIGN KEY (`ID_skill`) REFERENCES `skills` (`ID_skill`) ON DELETE CASCADE,
  ADD CONSTRAINT `ads_skills_ibfk_2` FOREIGN KEY (`ID_ad`) REFERENCES `ads` (`ID_ad`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `chat_members`
--
ALTER TABLE `chat_members`
  ADD CONSTRAINT `chat_members_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_members_ibfk_2` FOREIGN KEY (`ID_chat`) REFERENCES `chats` (`ID_chat`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `educations`
--
ALTER TABLE `educations`
  ADD CONSTRAINT `educations_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`ID_chat`) REFERENCES `chats` (`ID_chat`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `responses`
--
ALTER TABLE `responses`
  ADD CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `responses_ibfk_2` FOREIGN KEY (`ID_ad`) REFERENCES `ads` (`ID_ad`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`ID_profile`) REFERENCES `users` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_skills`
--
ALTER TABLE `user_skills`
  ADD CONSTRAINT `user_skills_ibfk_1` FOREIGN KEY (`ID_skill`) REFERENCES `skills` (`ID_skill`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_skills_ibfk_2` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `workexps`
--
ALTER TABLE `workexps`
  ADD CONSTRAINT `workexps_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `сertificates`
--
ALTER TABLE `сertificates`
  ADD CONSTRAINT `сertificates_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `users` (`ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
