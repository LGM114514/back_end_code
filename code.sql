/*
 Navicat Premium Data Transfer

 Source Server         : LG
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : code

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 12/12/2023 21:24:46
*/

DROP DATABASE IF EXISTS code;
CREATE DATABASE code;
USE code;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `cat_id` int NOT NULL,
  `cat_pid` int NULL DEFAULT NULL,
  `cat_Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cat_level` int NULL DEFAULT NULL,
  `children` json NULL,
  PRIMARY KEY (`cat_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 0, 'PC端', 0, '[{\"cat_id\": 10, \"cat_pid\": 1, \"cat_Name\": \"竞技类\", \"children\": [{\"cat_id\": 30, \"cat_pid\": 10, \"cat_Name\": \"英雄联盟\", \"children\": [], \"cat_level\": 2}, {\"cat_id\": 31, \"cat_pid\": 10, \"cat_Name\": \"永劫无间\", \"children\": [], \"cat_level\": 2}], \"cat_level\": 1}]');
INSERT INTO `category` VALUES (2, 0, '安卓端', 0, '[{\"cat_id\": 20, \"cat_pid\": 2, \"cat_Name\": \"休闲类\", \"children\": [{\"cat_id\": 60, \"cat_pid\": 20, \"cat_Name\": \"碧蓝航线\", \"children\": [], \"cat_level\": 2}, {\"cat_id\": 61, \"cat_pid\": 20, \"cat_Name\": \"蔚蓝档案\", \"children\": [], \"cat_level\": 2}], \"cat_level\": 1}]');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createTime` timestamp NOT NULL,
  `commentator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `game_infosheetId` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `game_infosheetId`(`game_infosheetId`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`game_infosheetId`) REFERENCES `game_infosheet` (`gid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '你好', '2023-12-02 19:48:02', 'LGG', 1);
INSERT INTO `comment` VALUES (2, '你好', '2023-12-02 19:52:44', 'LGG', 1);
INSERT INTO `comment` VALUES (3, '好便宜啊', '2023-12-02 19:54:26', 'LGG', 2);
INSERT INTO `comment` VALUES (4, '抽爆！', '2023-12-02 20:19:54', 'LGM', 2);

-- ----------------------------
-- Table structure for game_infosheet
-- ----------------------------
DROP TABLE IF EXISTS `game_infosheet`;
CREATE TABLE `game_infosheet`  (
  `gid` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `createTime` datetime NULL DEFAULT NULL,
  `caId` int NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `imagePath` json NULL,
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_infosheet
-- ----------------------------
INSERT INTO `game_infosheet` VALUES (1, '商城全场半价活动预告', '<p><strong>活动时间：2023年9月28日10:00-10月7日9:59</strong></p><p>全场半价：活动期间，商城在售的英雄、非限定皮肤、炫彩、图标、守卫、表情、加成道具、改名卡、额外符文页限时半价，另外云顶之弈也有部分小小英雄参与本次半价活动，详情参见附表一。</p><p><strong>注意：2023年3月28日以后上架的新道具将不参与此次活动。</strong></p><p>&nbsp;</p><p><strong>买半价皮肤，随机返利：</strong></p><p>全场半价期间，每购买1款半价皮肤，可随机返利1次，返利最高直接免单。随机返利活动仅适用于在游戏商城、掌盟商城、道聚城网页、道聚城客户端渠道购买。其他渠道如：游戏微商店购买、游戏客户端下非游戏商城解锁皮肤(包括但不仅限于游戏准备画面下解锁皮肤、藏品页面，客户端内嵌页面解锁皮肤等)将不参与本次活动。活动道具范围仅限参与本次活动的半价皮肤，解锁其他半价道具不参与本次随机返利活动。</p><p>●当抽取到免单时，该皮肤对应实际支付价格等值点券将直接发放到购买的账户中。</p><p>●当抽到388/488/588/688点券等值返利金时，该返利金将储存在返利金池中。当池内返利金总额超过等值2000点券时，召唤师可以选择将储存的返利金兑换成点券并发放至账户内。</p><p>●当池内返利金不足等值2000点券时，不可将该返利金兑换成点券，需要累计满等值2000点券兑换。在活动结束时，未兑换成点券的返利金将被清空</p><p>以下是本次活动的一些注意事项：</p><p>1、本次活动，仅在游戏商城、掌盟商城、道聚城渠道购买半价皮肤可累积抽取返利金或免单机会。在其它渠道如：游戏微商店购买、游戏客户端下非游戏商城解锁皮肤(包括但不仅限于游戏准备画面下解锁皮肤、藏品页面，客户端内嵌页面解锁皮肤等中获得对应道具无法累积抽取返利金机会。购买除皮肤外的其他道具无法累积抽取返利金机会。</p><p>2、每次抽取获得的返利金将在页面累计，页面累计的返利金达到等值2000点券(或以上)，可选择手动一次性领取到游戏内，领取后页面的返利金奖池将清空。</p><p>3、全场半价结束后，召唤师仍然可以继续抽取返利金，截止到2023年10月15日23:59，将会停止抽取返利金，同时未兑换成点券的返利金余额将清空。</p><p>4、全场半价期间，所有处于炫装关系的且在下表中的皮肤将暂时取消炫装价格，而适用更低的五折价格，直至半价活动结束。</p><p>5、赠送、接受礼物均不累积抽取返利金机会【温馨提示：处于封号期间的游戏账户将无法接收赠礼，请谨慎操作。】</p><p>6、在此活动中Apple不是赞助者，也没有以任何形式参加活动。</p>', '2023-09-21 00:00:00', 51, '英雄联盟官方 ', '[{\"pic\": \"imgs/1695538403938.png\"}]');
INSERT INTO `game_infosheet` VALUES (2, '祈愿三连击已上线', '<p>亲爱的召唤师</p><p>祈愿三连击活动即将上线，6900点券可以解锁3款皮肤，并100%获得额外暴击奖励。第20次祈愿必定暴击至臻皮肤。</p><p>&nbsp;</p><p>活动时间：2023年9月20日10:00-2023年9月26日23:59</p><p>&nbsp;</p><p><strong>祈愿</strong></p><p>召唤师支付6900点券购买1个阴森枯木守卫(7天)获赠1次祈愿机会，可以获得<strong style=\"color: rgb(224, 62, 45);\">3款</strong>祈愿奖池中皮肤，优先获得未解锁道具。并有100%几率额外获得一份\"暴击\"奖励;</p><p><strong style=\"color: rgb(224, 62, 45);\">首次祈愿免费体验：</strong>召唤师将以0点券体验祈愿过程，祈愿结束后需支付6900点券解锁祈愿中获得的全部奖励，并可进行后续祈愿;</p><p>召唤师在每个大区最多可祈愿20次，当在一个大区祈愿次数达到20次时将无法继续祈愿。</p><p>&nbsp;</p><p><strong>选择职业和位置优选奖池</strong></p><p>祈愿开始前，召唤师可以分别在英雄的<strong style=\"color: rgb(224, 62, 45);\">职业定位</strong>(坦克、战士、刺客、法师、射手、辅助)以及<strong style=\"color: rgb(224, 62, 45);\">常见位置</strong>(上路、打野、中路、下路、辅助)进行选择(数据以游戏客户端13.16版本为准)。选择后，祈愿解锁的3款皮肤中，将至少包含<strong>1款</strong>所选职业定位英雄的皮肤和<strong>1款</strong>所选常见位置英雄的皮肤。(举例：召唤师小明选择了职业定位【法师】，及常见位置【中路】，则祈愿解锁的皮肤中至少包含1款【法师】职业英雄的皮肤和1款【中路】英雄的皮肤)。召唤师也可以选择不进行上述的操作，则祈愿获得的3款皮肤均随机从祈愿奖池中解锁。</p><p>注意：当召唤师已解锁奖池中所选定的职业定位或常见位置的全部英雄皮肤，仍继续进行祈愿，将从总祈愿奖池中随机解锁皮肤。</p><p>冷却时间：在召唤师每次对常见位置或职业定位进行选择操作后，将进入5分钟的冷却状态(位置和职业的冷却时间单独计算)，该状态下不可更换选择;当召唤师在某次祈愿后将祈愿奖池内的选定的常见位置或职业对应英雄的皮肤全部解锁，则相应的常见位置或职业冷却时间立即清零;</p><p>&nbsp;</p><p><strong>暴击</strong></p><p>每次祈愿除了可以解锁3款皮肤以外还可以100%获得1次\"暴击\"奖励，暴击规则如下：</p><p>前19次祈愿，将可能暴击出以下道具：</p><p>●&nbsp;祈愿代金券，将在下次抽取过程中自动使用，不可叠加不可累计不可提现;</p><p>●&nbsp;额外1款祈愿奖池中的皮肤。即本次祈愿召唤师共计解锁4款皮肤;</p><p>●&nbsp;额外2款祈愿奖池中的皮肤。即本次祈愿召唤师共计解锁5款皮肤;</p><p>●&nbsp;免单券，即下次祈愿支付0点券;</p><p>第20次祈愿，<strong style=\"color: rgb(224, 62, 45);\">100%暴击出1款随机至臻皮肤</strong>，优先获得未解锁道具。如已拥有全部道具，则可以获得125神话精萃。详情参加文末奖池</p><p>&nbsp;</p><p><strong>皮肤解锁规则：</strong></p><p>祈愿解锁皮肤的规则均为优先解锁奖池中召唤师所未拥有的皮肤且领取到当前大区;</p><p>当召唤师已解锁奖池中所选定的职业定位或常见位置的全部英雄皮肤仍继续进行祈愿，将从祈愿奖池全部皮肤中随机解锁未拥有的皮肤;</p><p>当召唤师已解锁祈愿奖池中全部皮肤仍继续进行祈愿，将随机从祈愿奖池中获得重复皮肤，召唤师可以将其领取到其他大区;</p><p>温馨提示：在祈愿过程中召唤师请勿通过其他购买渠道或活动解锁奖池中的皮肤，上述操作可能导致祈愿解锁重复皮肤;</p>', '2023-09-19 00:00:00', 51, '英雄联盟官方', '[{\"pic\": \"imgs/1695538481763.jpg\"}]');
INSERT INTO `game_infosheet` VALUES (3, '永劫无间X杨国福联动', '<p>	<span style=\"color: rgb(50, 50, 50);\">金秋九月，正值《永劫无间》2023年度高校赛秋季赛来临之际，永劫无间携手国民麻辣烫品牌杨国福开启热辣联动，为高校赛选手们加油助威！</span></p><p>	9月20日至10月7日，使用外卖APP或前往杨国福活动门店购买本次联动套餐（天选之人餐、不朽荣光餐）的任意一份，即可领取专属极品动态头像【麻辣】、游戏表情气泡【麻了】、珍藏明信片、限定表情贴纸等多重好礼。</p><p>	9月20日至10月7日，使用外卖APP或前往杨国福活动门店购买本次联动套餐（天选之人餐、不朽荣光餐）的任意一份，即可领取专属极品动态头像【麻辣】、游戏表情气泡【麻了】、珍藏明信片、限定表情贴纸等多重好礼。</p><p>	9月20日至10月7日，使用外卖APP或前往杨国福活动门店购买本次联动套餐（天选之人餐、不朽荣光餐）的任意一份，即可领取专属极品动态头像【麻辣】、游戏表情气泡【麻了】、珍藏明信片、限定表情贴纸等多重好礼。</p><p><br></p>', '2023-09-20 00:00:00', 52, '永劫无间官方', '[{\"pic\": \"imgs/1695538802668.png\"}]');
INSERT INTO `game_infosheet` VALUES (4, '永劫无间X百度地图联动再启', '<p>	<span style=\"color: rgb(50, 50, 50);\">8月14日，永劫无间与百度地图再次梦幻联动，玉玲珑导航语音包正式上线，黄昏谷小狐狸与你一同结伴出行！</span></p><p><span class=\"ql-cursor\">﻿</span>	设定好起始点与终点，就能听到小狐狸慵懒的声音：“让给你指条明路吧。”</p><p>	当你超速时，小狐狸会提醒你：“可别超速，你的魂只有我能勾。”</p><p>	道路拥挤时，小狐狸也会发发牢骚：“哎呀，前方的行驶速度好慢啊！难道这些凡人不知道时间的宝贵吗？”</p><p>	生动有趣的定制语音为你指路，让枯燥的旅途变得活力满满！</p><p>	&nbsp;</p><p>	伴随玉玲珑语音包上线的还有永劫无间主题装扮与导航车标。用户可以进入百度地图App，在“永劫无间”专题下将主题装扮设置为永劫无间主题，并且将车标更换为萌萌的迦南、无尘、胡桃、顾清寒、宁红夜等。</p>', '2023-08-16 00:00:00', 52, '永劫无间官方', '[{\"pic\": \"imgs/1695539004809.jpg\"}, {\"pic\": \"imgs/1695539009406.jpg\"}, {\"pic\": \"imgs/1695539014021.jpg\"}]');
INSERT INTO `game_infosheet` VALUES (5, '《碧蓝航线》9月金秋版本上线', '<p><span style=\"color: rgb(51, 51, 51);\">9月14日，由bilibili游戏独家代理发行，蛮啾网络与勇仕网络共同研发的二次元即时海战手游《碧蓝航线》全新重磅版本如期而至，游戏内大型主题活动、新角色、新礼服及相应福利活动同步上线，在这初秋时节为广大指挥官献上了一道游戏的饕餮盛宴！</span></p><p><strong>【金秋时节再相聚，《碧蓝航线》重磅版本上线】</strong></p><p>从炎炎夏日到微凉金秋，《碧蓝航线》全新版本更新了众多大型主题活动、特色玩法和限时免费兑换的限定家具、外观装备等福利奖品道具，在版本活动周期内，指挥官们还可以通过限时建造获得全新舰船「海上传奇-猃」、「超稀有-檚」、「超稀有-鳂」以及全新的改造船「狏·改」，不知道有多少指挥官已经将新的海上传奇收入囊中了呢。</p><p>《碧蓝航线》9月限时大型活动「须臾望月抄」已经正式上线，为了守护重樱而汇聚的少女们将献出所有倾力一战，从9月14日维护后~10月4日23:59，「须臾望月抄」活动关卡限时开放，活动期间，通过活动关卡作战、完成对应任务等方式可累积活动道具「樱花签」并获取各种丰厚奖励！</p><p><br></p>', '2023-09-20 00:00:00', 100, '碧蓝航线官方', '[{\"pic\": \"imgs/1695540253397.png\"}, {\"pic\": \"imgs/1695540261562.png\"}]');
INSERT INTO `game_infosheet` VALUES (6, '限时活动「信标・烬」挑战及限定换装', '<p><span style=\"color: rgb(25, 25, 25);\">《碧蓝航线》台服将于9月21日14:00-18:00进行维护，维护后开启限时活动「信标・烬」挑战。</span></p><p class=\"ql-align-justify\"><strong><span class=\"ql-cursor\">﻿</span>1.商城新增角色换装：</strong></p><p class=\"ql-align-justify\">信浓【胧月十夜】；</p><p class=\"ql-align-justify\">独立【「独立」品牌】；</p><p class=\"ql-align-justify\">赤城【朱绢余醺】；</p><p class=\"ql-align-justify\">加贺【白羽风华】；</p><p class=\"ql-align-justify\">初霜【吉时祝宴】；</p><p class=\"ql-align-justify\">有明【四季团圆】；</p><p class=\"ql-align-justify\">榛名【绯红Innocence】；</p><p class=\"ql-align-justify\">威奇塔【“将军”的晚宴】；</p><p class=\"ql-align-justify\">巴尔的摩【夜风Minuet】L2D；</p><p class=\"ql-align-justify\">雷【晨曦精灵Ikatuchi】；</p><p class=\"ql-align-justify\">电【月下妖精Inatuma】；</p><p class=\"ql-align-justify\">绫波【黯然礼装】L2D；</p><p class=\"ql-align-justify\">艾塞克斯【Craft Fairytail】L2D；</p><p class=\"ql-align-justify\">谢菲尔德【黑鸦的晚宴】；</p><p class=\"ql-align-justify\">路易九世【华服的圣骑士】L2D；</p><p class=\"ql-align-justify\">能代【夜响的绝园】。</p><p class=\"ql-align-justify\"><strong>2.新增角色：亚利桑那・META（可于「信标・烬」活动获得）</strong></p><p><br></p>', '2023-09-21 00:00:00', 100, '碧蓝航线官方', '[{\"pic\": \"imgs/1695541360799.jpeg\"}, {\"pic\": \"imgs/1695541367708.png\"}]');
INSERT INTO `game_infosheet` VALUES (7, '【预告】限时招募即将更新', '<p><span style=\"color: rgb(63, 68, 74);\">“欢迎连接【什亭之箱】，老师。”</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">限时招募【落英缤纷的假面舞会】、【闪光，点亮世界】将于 09月28日 维护结束后 开启！</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">我们将发放【10次招募券×1】作为本期招募助力。</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">■ 可领取时间</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 维护结束后 ~ 10月12日 13:59 维护开始前</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">以下是本期限时招募的详细信息：</span></p><p><span style=\"color: rgb(63, 68, 74);\">限时招募【落英缤纷的假面舞会】即将开启！在本次招募中，全新成员“梓（3★）”、“花子（2★）”登场，且招募概率得到提升！</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 招募时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 维护结束后 ~ 10月12日 13:59 维护开始前</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 注意事项</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• “梓（3★）”、“花子（2★）”将加入同期和后续的【长期招募】、【限时招募】中。</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">※ 具体成员信息和概率信息可以前往游戏内招募界面查看。</span></p><p><br></p>', '2023-09-22 00:00:00', 102, '蔚蓝档案官方', '[{\"pic\": \"imgs/1695542314586.png\"}, {\"pic\": \"imgs/1695542319941.png\"}]');
INSERT INTO `game_infosheet` VALUES (8, '【预告】主线剧情更新', '<p><span style=\"color: rgb(63, 68, 74);\">“欢迎连接【什亭之箱】，老师。”</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">伊甸园条约篇 第1章“补习，正式开始！”（1~9话）即将更新！</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">陷入不及格危机的崔尼蒂问题学员们正在等待救援。</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">快来成为补习部的负责人，带领她们走出危机吧！</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 更新时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 &nbsp;维护结束后</span></p><p><span style=\"color: rgb(63, 68, 74);\">■ 主线故事更新纪念奖励</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 青辉石 × 1200</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">■ 主线故事助力奖励</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 信用积分 × 2000000</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 初级活动报告书 × 50</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 中级活动报告书 × 20</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 高级活动报告书 × 10</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 初级战术教育光盘（崔尼蒂） × 30</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 中级战术教育光盘（崔尼蒂） × 20</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">&nbsp;• 高级战术教育光盘（崔尼蒂） × 10</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 邮件发放时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 维护结束后 ~ 10月12日 13:59 维护开始前</span></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">邮件有效期为14天，请注意及时领取。</span></p><p><br></p>', '2023-09-22 00:00:00', 102, '蔚蓝档案官方', '[{\"pic\": \"imgs/1695542447349.png\"}]');
INSERT INTO `game_infosheet` VALUES (9, '剑指亚洲之巅 冲刺活动开启！', '<p>各位召唤师们!</p><p>冲刺阶段任务开启！2023年8月31日起至2023年10月6日23:59期间，参与英雄联盟客户端内【剑指亚洲之巅】助威活动，即有机会赢取全新玉剑传说 舞龙卫皮肤!</p><p>活动期间，召唤师可以通过完成签到、对局、观赛等任务积累助威值，为英雄联盟项目选手加油助威，并逐步解锁包含皮肤、召唤师图标以及表情在内的丰富道具奖励。</p><p>9月25日至9月29日，英雄联盟项目赛事正式打响，【剑指亚洲之巅】助威活动将在此期间进入冲刺阶段，额外的冲刺任务将限时解锁，用丰富的助威值奖励帮助召唤师更快解锁奖励。冲刺任务仅开放5天，各位召唤师们可不要错过这次机会。(具体任务详见后文)</p><p>预祝召唤师们在整个9月享受竞技体育带来的视觉盛宴，同时也别忘了在英雄联盟完成任务免费赢取全新玉剑传说 舞龙卫皮肤。</p><p><strong style=\"color: rgb(224, 62, 45);\">温馨提示：需要注意的是，每个QQ仅可绑定一个大区参与活动。</strong></p><p>*冲刺阶段任务(2023年9月25日 16时48分更新)</p><p>1)冲刺!签到任务：每日登录活动页面签到，额外领取 200 助威值，上限600助威值</p><p>2)冲刺!对局任务：完成匹配对局，每局可领取 10 助威值，每日上限 80 助威值。</p><p>3)冲刺!观赛任务：在活动页面，指定时间观看英雄联盟项目赛事，观赛每满5分钟，可领取 50 助威值，活动期间上限 150 助威值。</p><p>4)冲刺!观赛领图标边框：</p><p>&nbsp;&nbsp;&nbsp;方式一：在活动页面，指定时间观看英雄联盟项目赛事，累计观赛15分钟以上。</p><p>&nbsp;&nbsp;&nbsp;方式二：9月25日至10月6日，赢得一场系统匹配的对局(云顶之弈模式达到前四)。</p><p>&nbsp;&nbsp;&nbsp;可领取 【玉剑传说 舞龙卫 图标及边框】</p><p>5)冲刺!每日抽炫彩：在活动页面，停留倒计时15分钟结束，即可抽取一次福利，每日限1次。(倒计时结束即可领取宝箱，非直播时段不计入观赛时长)</p><p>观赛福利所含奖励概率如下：</p><p>&nbsp;&nbsp;&nbsp;玉剑传说 舞龙卫 翡翠 ，获取概率0.1%，限量5000份</p><p>&nbsp;&nbsp;&nbsp;蓝色精萃*100，获取概率50%，限量50万份</p><p>&nbsp;&nbsp;&nbsp;助威值*50，获取概率49.9%，不限量</p>', '2023-08-31 00:00:00', 51, '英雄联盟官方', '[{\"pic\": \"imgs/1695714084623.jpg\"}]');
INSERT INTO `game_infosheet` VALUES (10, '永劫无间×不凡玩品收藏卡牌', '<p class=\"ql-align-center\">	全体英雄<span style=\"color: rgb(184, 58, 58);\">看向这边！</span></p><p class=\"ql-align-center\">	今天劫宝带来了一个<span style=\"color: rgb(184, 58, 58);\">好消息</span></p><p class=\"ql-align-center\">	<span style=\"color: rgb(184, 58, 58);\">大家都准备好了吗！！！</span></p><p class=\"ql-align-center\">	那就是</p><p class=\"ql-align-center\">	……</p><p class=\"ql-align-center\">	<span style=\"color: rgb(184, 58, 58);\">永劫无间</span>官方携手<span style=\"color: rgb(184, 58, 58);\">不凡玩品BUFFUN</span></p><p class=\"ql-align-center\">	以游戏内的精美原画为主体</p><p class=\"ql-align-center\">	共同推出永劫无间<span style=\"color: rgb(184, 58, 58);\">破晓先行者系列收藏卡</span>啦！</p><p class=\"ql-align-center\">	本次永劫无间与不凡玩品BUFFUN的合作</p><p class=\"ql-align-center\">	通过一种<span style=\"color: rgb(184, 58, 58);\">全新的方式</span></p><p class=\"ql-align-center\">	将<span style=\"color: rgb(184, 58, 58);\">游戏与现实</span>完美连结</p><p class=\"ql-align-center\">	把游戏内的画面以及<span style=\"color: rgb(184, 58, 58);\">独属于</span>永劫无间的<span style=\"color: rgb(184, 58, 58);\">世界观</span></p><p class=\"ql-align-center\">	更为广泛的传播</p><p class=\"ql-align-center\">	吸引<span style=\"color: rgb(184, 58, 58);\">收藏爱好者们</span>来了解永劫无间！</p><p>	&nbsp;</p><h3>限量卡牌等你收集！</h3><p class=\"ql-align-center\">	破晓先行者系列收藏卡不光有精美的<span style=\"color: rgb(184, 58, 58);\">人物</span>卡和<span style=\"color: rgb(184, 58, 58);\">武器</span>卡</p><p class=\"ql-align-center\">	还有限量的<span style=\"color: rgb(184, 58, 58);\">配音签字卡</span></p><p class=\"ql-align-center\">	更有<span style=\"color: rgb(184, 58, 58);\">巅峰亮银卡</span>和<span style=\"color: rgb(184, 58, 58);\">至尊魂玉卡</span>两款<span style=\"color: rgb(184, 58, 58);\">高罕卡</span></p><p class=\"ql-align-center\">*亮银卡</p><p class=\"ql-align-center\">	巅峰亮银卡采用了<span style=\"color: rgb(184, 58, 58);\">无塑壳裸银镶嵌</span>工艺</p><p class=\"ql-align-center\">	每张卡上都有<span style=\"color: rgb(184, 58, 58);\">10g</span>的<span style=\"color: rgb(184, 58, 58);\">银</span></p><p class=\"ql-align-center\">	搭配上游戏内插画</p><p class=\"ql-align-center\">	<span style=\"color: rgb(184, 58, 58);\">完美还原</span>了游戏世界的<span style=\"color: rgb(184, 58, 58);\">刀光剑影</span></p><p class=\"ql-align-center\">*至尊魂玉卡</p><p class=\"ql-align-center\">	而至尊魂玉卡更是镶嵌了<span style=\"color: rgb(184, 58, 58);\">A级天然翡翠</span></p><p class=\"ql-align-center\">	经过精细的雕琢还原了<span style=\"color: rgb(184, 58, 58);\">花型魂玉</span></p><p class=\"ql-align-center\">	入手温润，极具收藏价值!&nbsp;</p><p class=\"ql-align-center\">	破晓先行者系列共有</p><p class=\"ql-align-center\">	5款<span style=\"color: rgb(184, 58, 58);\">常规卡</span>、4款<span style=\"color: rgb(184, 58, 58);\">稀有卡</span>、5款<span style=\"color: rgb(184, 58, 58);\">限量稀有卡</span>以及4款<span style=\"color: rgb(184, 58, 58);\">高罕卡</span></p><p class=\"ql-align-center\">	总计<span style=\"color: rgb(184, 58, 58);\">18款卡种</span>等你来一一<span style=\"color: rgb(184, 58, 58);\">收藏</span>！</p><p><br></p>', '2023-07-17 00:00:00', 52, '永劫无间官方', '[{\"pic\": \"imgs/1695714361664.png\"}]');
INSERT INTO `game_infosheet` VALUES (11, '【预告】掉落量2倍活动', '<p><span style=\"color: rgb(63, 68, 74);\">“欢迎连接【什亭之箱】，老师。”</span></p><p><br></p><p>&nbsp;</p><p><span style=\"color: rgb(63, 68, 74);\">【道具掉落量2倍活动】即将开启！请不要错过哦！</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">一、【悬赏通缉】掉落量2倍</strong></p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 04:00 ~ 10月05日 03:59</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动内容</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">活动期间，完成【悬赏通缉】时，获得的所有掉落道具数量变为2倍。</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">二、【日程】掉落量2倍</strong></p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 04:00 ~ 10月05日 03:59</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动内容</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">活动期间，完成【日程】时，获得的所有掉落道具数量变为2倍。</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">三、【任务(普通难度)】掉落量2倍</strong></p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">09月28日 04:00 ~ 10月02日 03:59</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动内容</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">活动期间，完成【任务(普通难度)】时，获得的所有掉落道具数量变为2倍。</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">四、【任务(困难难度)】掉落量2倍</strong></p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">10月02日 04:00 ~ 10月05日 03:59</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动内容</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">活动期间，完成【任务(困难难度)】时，获得的所有掉落道具数量变为2倍。</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">五、【特别委托】掉落量2倍</strong></p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动时间</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">10月05日 04:00 ~ 10月12日 03:59</span></p><p><br></p><p>&nbsp;</p><p><strong style=\"color: rgb(63, 68, 74);\">■ 活动内容</strong></p><p><br></p><p><span style=\"color: rgb(63, 68, 74);\">活动期间，完成【特别委托】时，获得的所有掉落道具数量变为2倍。</span></p><p><br></p>', '2023-09-25 00:00:00', 102, '蔚蓝档案官方', '[{\"pic\": \"imgs/1695714584906.png\"}]');

-- ----------------------------
-- Table structure for rights
-- ----------------------------
DROP TABLE IF EXISTS `rights`;
CREATE TABLE `rights`  (
  `id` int NOT NULL,
  `pid` int NULL DEFAULT NULL,
  `authName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rights
-- ----------------------------
INSERT INTO `rights` VALUES (101, 0, '用户管理', 0, 'user');
INSERT INTO `rights` VALUES (102, 0, '资讯管理', 0, 'information');
INSERT INTO `rights` VALUES (103, 0, '权限管理', 0, 'rightsation');
INSERT INTO `rights` VALUES (105, 101, '用户列表', 1, 'userslist');
INSERT INTO `rights` VALUES (110, 102, '资讯列表', 1, 'informationlist');
INSERT INTO `rights` VALUES (111, 102, '资讯分类', 1, 'informationclass');
INSERT INTO `rights` VALUES (115, 103, '权限列表', 1, 'rights');
INSERT INTO `rights` VALUES (116, 103, '角色列表', 1, 'roles');

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `id` int NOT NULL,
  `authName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `children` json NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES (101, '用户管理', 0, 'user', '[{\"id\": 105, \"path\": \"userslist\", \"level\": 1, \"authName\": \"用户列表\", \"children\": []}]');
INSERT INTO `shop` VALUES (102, '资讯管理', 0, 'information', '[{\"id\": 110, \"path\": \"informationlist\", \"level\": 1, \"authName\": \"资讯列表\", \"children\": []}, {\"id\": 111, \"path\": \"informationclass\", \"level\": 1, \"authName\": \"资讯分类\", \"children\": []}]');
INSERT INTO `shop` VALUES (103, '权限管理', 0, 'rightsation', '[{\"id\": 115, \"path\": \"rights\", \"level\": 1, \"authName\": \"权限列表\", \"children\": []}, {\"id\": 116, \"path\": \"roles\", \"level\": 1, \"authName\": \"角色列表\", \"children\": []}]');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `uid` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mg_state` tinyint(1) NULL DEFAULT 1,
  `rightId` int NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '$2b$10$2QQmu1BWYFCbQLSmNR1vgOjEYRnEqnO8MIRpeWkTU/jGc2cp0hZU6', 'user1@example.com', 1, 1);
INSERT INTO `users` VALUES (2, 'HXY', '$2b$10$KGQrjOcDQIzPSLSQtLl51O9AZcEsy//aoraSP0Afdl3Jo5si5Z5/u', 'b@qq.com', 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
