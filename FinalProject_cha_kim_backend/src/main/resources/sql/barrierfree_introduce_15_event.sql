-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: barrierfree
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `introduce_15_event`
--

DROP TABLE IF EXISTS `introduce_15_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `introduce_15_event` (
  `contentid` varchar(20) NOT NULL COMMENT '컨텐츠 ID',
  `agelimit` varchar(255) DEFAULT NULL COMMENT '관람가능연령 (체험종류에 따라 다름)',
  `bookingplace` varchar(255) DEFAULT NULL COMMENT '예매처',
  `discountinfofestival` varchar(255) DEFAULT NULL COMMENT '할인정보',
  `eventenddate` varchar(255) DEFAULT NULL COMMENT '행사종료일',
  `eventhomepage` varchar(255) DEFAULT NULL COMMENT '행사홈페이지',
  `eventplace` varchar(255) DEFAULT NULL COMMENT '행사장소',
  `eventstartdate` varchar(255) DEFAULT NULL COMMENT '행사시작일',
  `festivalgrade` varchar(255) DEFAULT NULL COMMENT '축제등급',
  `placeinfo` varchar(255) DEFAULT NULL COMMENT '행사장위치안내',
  `playtime` varchar(255) DEFAULT NULL COMMENT '공연시간',
  `program` varchar(255) DEFAULT NULL COMMENT '행사프로그램',
  `spendtimefestival` varchar(255) DEFAULT NULL COMMENT '관람소요시간',
  `sponsor1` varchar(255) DEFAULT NULL COMMENT '주최자정보',
  `sponsor1tel` varchar(255) DEFAULT NULL COMMENT '주최자연락처',
  `sponsor2` varchar(255) DEFAULT NULL COMMENT '주관사정보',
  `sponsor2tel` varchar(255) DEFAULT NULL COMMENT '주관사연락처',
  `subevent` varchar(2000) DEFAULT NULL,
  `usetimefestival` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`contentid`),
  CONSTRAINT `content_15_fk` FOREIGN KEY (`contentid`) REFERENCES `places` (`contentid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `introduce_15_event`
--

LOCK TABLES `introduce_15_event` WRITE;
/*!40000 ALTER TABLE `introduce_15_event` DISABLE KEYS */;
INSERT INTO `introduce_15_event` VALUES ('1402009','','','','20230924','','원주 댄싱공연장 및 원주시 일대','20230922','','','','','','원주시','033-760-9881~4','(재)원주문화재단','','',''),('141105','','','','20231029','','고성군 당항포관광지','20230922','','','월~목 09:00 ~ 18:00<br> (매주 금, 토, 9/28, 10/1, 10/8 09:00 22:00)','','','(재)경남고성공룡세계엑스포조직위원회','055-670-3814','(재)경남고성공룡세계엑스포조직위원회','055-670-3814','','대인 18,000원(예매권 14,000원) 소인 12,000원(예매권 7,000원) <br>사전예매기간 2023. 5. 1. ~ 9. 21'),('141918','누구나','','','20231022','','대전컨벤션센터 제2전시장, 한빛탑, 대덕특구, 원도심 일원','20231020','','','10:00~17:30','','','대전광역시,대덕연구개발특구기관장협의회, 대전시교육청 등','042-250-1452','대전관광공사(대전과학문화지역거점센터)','','','무료'),('1754946','','','','20241231','','포천시 허브아일랜드','20240101','','','[월,화,목]오후2:00~오후10:00<br>[금]오후2:00~오전12:00<br>[토]오후12:00~오전12:00<br>[일]오후12:00~오후10:00 (수요일 정기휴장)','','','허브아일랜드','031-535-6494','','','','[평일] 일반: 10,000원  우대(37개월~중학생): 8,000원 <br>[주말] 일반: 12,000원 우대(37개월~중학생): 10,000원'),('1763715','','','','20240208','','산정호수 조각공원일대','20231230','','','10:00~17:00(주말 및 공휴일 17:30)','','','산정호수마을회','031-532-6135','','','','유료<br>6,000원~20,000원'),('1809861','전 연령','','','20231028','','','20230701','','','','','60분','(사)춘천연극제, G1방송','033-241-4345','(사)춘천연극제','','','유/무료(유료 : 카카오톡 채널 등록시 10,000원)'),('1824778','공연마다 상이함. 홈페이지 참조(<a href=\"http://ttaf.kr\"_blank\" title=\"새창: 홈페이지로 이동\">http://ttaf.kr</a>)','','','20230716','','통영시민문화회관, 벅수골소극장, 생활 속의 공간','20230707','','','10시 ~ 21시','','공연마다 상이함. 홈페이지 참조(<a href=\"http://ttaf.kr\"_blank\" title=\"새창: 홈페이지로 이동\">http://ttaf.kr</a>)','통영시, 통영연극예술축제위원회','055-645-6379 / 010-5465-6379','','','','홈페이지 참조(<a href=\"http://ttaf.kr\"_blank\" title=\"새창: 홈페이지로 이동\">http://ttaf.kr</a>)'),('2479634','전 연령','','','20231112','','한국농수산식품유통공사 At센터','20231110','','','09:00-17:00','','약 120분','(사)세계음식문화연구원,(사)한국푸드코디네이터협회','남용진(02-577-1138, 010-2750-4432)','(사)세계음식문화연구원,(사)한국푸드코디네이터협회','남용진(02-577-1138, 010-2750-4432)','','8,000원(사전 등록 5,000원)'),('2495916','','','','20230915','','휴애리자연생활공원 내','20230717','','','9:00 - 18:00(입장마감 17:30)','','','휴애리 자연생활공원','064-732-2114','','064-732-2114','','성   인:13,000원/단체:9,000원/도민:8,000원<br>  청소년:11,000원/단체:8,000원/도민:7,000원<br>  어린이:10,000원/단체:7,000원/도민:6,000원<br>  경로/장애인/국가유공자/군인/경찰/소방관 단체요금 적용<br>  단체요금 20명 부터 적용<br>  35개월까지는 무료입장<br>  세자녀 50%할인(자녀만 할인혜택, 고등학생까지)<br>  제주특별자치도민, 장애인, 유공자, 군인, 경찰, 소방관은 반드시 신분증 및 증명서를 제시해야 합니다.'),('2517217','전연령','','','20240212','','양잠테마단지 내','20231125','','','13:00~20:00','','','영농조합법인 고니골/영농조합법인 원주양잠/고니골농장','033-766-0207','영농조합법인 고니골','','','주간:천원 / 야간:성인(오천원),소인(3천원)'),('2550263','전연령 가능','','','20230815','','세미원','20230701','','','09:00~20:00','','약 1시간','(재)세미원','031-775-1835','(재)세미원','031-775-1835','- 마음의 정화, 연꽃세상<br />\n- 조영철이재형 Light Art<br />\n- 김명희 흙인형 전시<br />\n- 녹색미술회 깃발전시<br />\n- 현대미술작가회 전시<br />\n- 권성녀 민화초대전<br />\n- 백준승 초대전<br />\n- 연꽃 그리기, 페이스페인팅, 인증샷 이벤트<br />\n- 소원지 쓰기, 작가공방체험<br />\n- 전통놀이 한마당, 토요음악회<br />\n- interactive art체험, 연꽃문화체험교실<br />\n- 천연가죽 공예, 자개 공예, 캐리커처','구분 개인 적용대상<br>  일반 5,000원 : 만 19세 이상 성인<br> 우대 3,000원 : 만 6세 이상 어린이, 청소년,<br> 만65세 이상, 장애인 경증(4~6급)<br> 단체 3,000원 : 50인 이상, 중복할인 안됨<br> 무료 : 만 5세 이하, 양평군민(1인 1매 혜택),<br> 장애인 중증(1~3급) 본인 및 동반보호자 1인,<br> 국가유공자 및 배우자, 현역사병, 기초생활수급 1종 대상자(서류 지참),<br> 의사자 유족 및 의상자<br> ※ 양평군민은 본인의 거주지를 증명할수 있는 신분증(주민등록증,운전면허증 등)이 있어야 할인 혜택을 받으실수 있습니다.(신분증 제시자 1인 1매 혜택)<br>  ※ 요금 할인 및 무료입장 대상은 증명할수 있는 신분증 또는 복지카드를 제시해 주시기 바랍니다.'),('2636295','','','','20240107','','네이처파크','20231125','','','','','','리조트 스파밸리','010-5267-4343','네이처파크','','','유료<br> (정상가 성인1인 20,000원/소인1인 18,000원/24개월미만 무료)'),('2646267','','','','20241117','','','20240219','','','15:00~22:00  (매주 수요일 휴무)','','','청도 프로방스','054-372-5050','','','','12,000원(주중,주말, 대인기준)');
/*!40000 ALTER TABLE `introduce_15_event` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-19 19:25:58
