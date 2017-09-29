<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  <!-- -->
  <xsl:variable name="char-to-pinyin-map">
    <map>
      <group key="a">
        <item><char>āng</char><pinyin>ang1</pinyin></item>
        <item><char>áng</char><pinyin>ang2</pinyin></item>
        <item><char>ǎng</char><pinyin>ang3</pinyin></item>
        <item><char>àng</char><pinyin>ang4</pinyin></item>
        
        <item><char>āi</char><pinyin>ai1</pinyin></item>
        <item><char>ái</char><pinyin>ai2</pinyin></item>
        <item><char>ǎi</char><pinyin>ai3</pinyin></item>
        <item><char>ài</char><pinyin>ai4</pinyin></item>
                
        <item><char>ān</char><pinyin>an1</pinyin></item>
        <item><char>án</char><pinyin>an2</pinyin></item>
        <item><char>ǎn</char><pinyin>an3</pinyin></item>
        <item><char>àn</char><pinyin>an4</pinyin></item>
        
        <item><char>āo</char><pinyin>ao1</pinyin></item>
        <item><char>áo</char><pinyin>ao2</pinyin></item>
        <item><char>ǎo</char><pinyin>ao3</pinyin></item>
        <item><char>ào</char><pinyin>ao4</pinyin></item>

        <item><char>ā</char><pinyin>a1</pinyin></item>
        <item><char>á</char><pinyin>a2</pinyin></item>
        <item><char>ǎ</char><pinyin>a3</pinyin></item>
        <item><char>à</char><pinyin>a4</pinyin></item>
        
      </group>
      <group key="b">
        <item><char>biāng</char><pinyin>biang1</pinyin></item>
        <item><char>biáng</char><pinyin>biang2</pinyin></item>
        <item><char>biǎng</char><pinyin>biang3</pinyin></item>
        <item><char>biàng</char><pinyin>biang4</pinyin></item>
        
        <item><char>bāng</char><pinyin>bang1</pinyin></item>
        <item><char>báng</char><pinyin>bang2</pinyin></item>
        <item><char>bǎng</char><pinyin>bang3</pinyin></item>
        <item><char>bàng</char><pinyin>bang4</pinyin></item>
        
        <item><char>bēng</char><pinyin>beng1</pinyin></item>
        <item><char>béng</char><pinyin>beng2</pinyin></item>
        <item><char>běng</char><pinyin>beng3</pinyin></item>
        <item><char>bèng</char><pinyin>beng4</pinyin></item>
        
        <item><char>biān</char><pinyin>bian1</pinyin></item>
        <item><char>bián</char><pinyin>bian2</pinyin></item>
        <item><char>biǎn</char><pinyin>bian3</pinyin></item>
        <item><char>biàn</char><pinyin>bian4</pinyin></item>
        
        <item><char>biāo</char><pinyin>biao1</pinyin></item>
        <item><char>biáo</char><pinyin>biao2</pinyin></item>
        <item><char>biǎo</char><pinyin>biao3</pinyin></item>
        <item><char>biào</char><pinyin>biao4</pinyin></item>
        
        <item><char>bāi</char><pinyin>bai1</pinyin></item>
        <item><char>bái</char><pinyin>bai2</pinyin></item>
        <item><char>bǎi</char><pinyin>bai3</pinyin></item>
        <item><char>bài</char><pinyin>bai4</pinyin></item>
        
        <item><char>bān</char><pinyin>ban1</pinyin></item>
        <item><char>bán</char><pinyin>ban2</pinyin></item>
        <item><char>bǎn</char><pinyin>ban3</pinyin></item>
        <item><char>bàn</char><pinyin>ban4</pinyin></item>
        
        <item><char>bāo</char><pinyin>bao1</pinyin></item>
        <item><char>báo</char><pinyin>bao2</pinyin></item>
        <item><char>bǎo</char><pinyin>bao3</pinyin></item>
        <item><char>bào</char><pinyin>bao4</pinyin></item>
        
        <item><char>bēi</char><pinyin>bei1</pinyin></item>
        <item><char>béi</char><pinyin>bei2</pinyin></item>
        <item><char>běi</char><pinyin>bei3</pinyin></item>
        <item><char>bèi</char><pinyin>bei4</pinyin></item>
        
        <item><char>bēn</char><pinyin>ben1</pinyin></item>
        <item><char>bén</char><pinyin>ben2</pinyin></item>
        <item><char>běn</char><pinyin>ben3</pinyin></item>
        <item><char>bèn</char><pinyin>ben4</pinyin></item>
        
        <item><char>bā</char><pinyin>ba1</pinyin></item>
        <item><char>bá</char><pinyin>ba2</pinyin></item>
        <item><char>bǎ</char><pinyin>ba3</pinyin></item>
        <item><char>bà</char><pinyin>ba4</pinyin></item>
        
        <item><char>bīng</char><pinyin>bing1</pinyin></item>
        <item><char>bíng</char><pinyin>bing2</pinyin></item>
        <item><char>bǐng</char><pinyin>bing3</pinyin></item>
        <item><char>bìng</char><pinyin>bing4</pinyin></item>
        
        <item><char>biē</char><pinyin>bie1</pinyin></item>
        <item><char>bié</char><pinyin>bie2</pinyin></item>
        <item><char>biě</char><pinyin>bie3</pinyin></item>
        <item><char>biè</char><pinyin>bie4</pinyin></item>
        
        <item><char>bīn</char><pinyin>bin1</pinyin></item>
        <item><char>bín</char><pinyin>bin2</pinyin></item>
        <item><char>bǐn</char><pinyin>bin3</pinyin></item>
        <item><char>bìn</char><pinyin>bin4</pinyin></item>
        
        <item><char>bī</char><pinyin>bi1</pinyin></item>
        <item><char>bí</char><pinyin>bi2</pinyin></item>
        <item><char>bǐ</char><pinyin>bi3</pinyin></item>
        <item><char>bì</char><pinyin>bi4</pinyin></item>
        
      	<item><char>bō</char><pinyin>bo1</pinyin></item>
        <item><char>bó</char><pinyin>bo2</pinyin></item>
        <item><char>bǒ</char><pinyin>bo3</pinyin></item>
        <item><char>bò</char><pinyin>bo4</pinyin></item>
        
      	<item><char>bū</char><pinyin>bu1</pinyin></item>
        <item><char>bú</char><pinyin>bu2</pinyin></item>
        <item><char>bǔ</char><pinyin>bu3</pinyin></item>
        <item><char>bù</char><pinyin>bu4</pinyin></item>
      </group>
      <group key="c">
          
        <item><char>chuāi</char><pinyin>chuai1</pinyin></item>
        <item><char>chuái</char><pinyin>chuai2</pinyin></item>
        <item><char>chuǎi</char><pinyin>chuai3</pinyin></item>
        <item><char>chuài</char><pinyin>chuai4</pinyin></item>
        
        <item><char>chuān</char><pinyin>chuan1</pinyin></item>
        <item><char>chuán</char><pinyin>chuan2</pinyin></item>
        <item><char>chuǎn</char><pinyin>chuan3</pinyin></item>
        <item><char>chuàn</char><pinyin>chuan4</pinyin></item>
        
        <item><char>chuāng</char><pinyin>chuang1</pinyin></item>
        <item><char>chuáng</char><pinyin>chuang2</pinyin></item>
        <item><char>chuǎng</char><pinyin>chuang3</pinyin></item>
        <item><char>chuàng</char><pinyin>chuang4</pinyin></item>
        
        <item><char>chāi</char><pinyin>chai1</pinyin></item>
        <item><char>chái</char><pinyin>chai2</pinyin></item>
        <item><char>chǎi</char><pinyin>chai3</pinyin></item>
        <item><char>chài</char><pinyin>chai4</pinyin></item>
        
        <item><char>chāng</char><pinyin>chang1</pinyin></item>
        <item><char>cháng</char><pinyin>chang2</pinyin></item>
        <item><char>chǎng</char><pinyin>chang3</pinyin></item>
        <item><char>chàng</char><pinyin>chang4</pinyin></item>
        
        <item><char>chān</char><pinyin>chan1</pinyin></item>
        <item><char>chán</char><pinyin>chan2</pinyin></item>
        <item><char>chǎn</char><pinyin>chan3</pinyin></item>
        <item><char>chàn</char><pinyin>chan4</pinyin></item>
        
        <item><char>chāo</char><pinyin>chao1</pinyin></item>
        <item><char>cháo</char><pinyin>chao2</pinyin></item>
        <item><char>chǎo</char><pinyin>chao3</pinyin></item>
        <item><char>chào</char><pinyin>chao4</pinyin></item>
        
        <item><char>cāng</char><pinyin>cang1</pinyin></item>
        <item><char>cáng</char><pinyin>cang2</pinyin></item>
        <item><char>cǎng</char><pinyin>cang3</pinyin></item>
        <item><char>càng</char><pinyin>cang4</pinyin></item>
        
        <item><char>cāi</char><pinyin>cai1</pinyin></item>
        <item><char>cái</char><pinyin>cai2</pinyin></item>
        <item><char>cǎi</char><pinyin>cai3</pinyin></item>
        <item><char>cài</char><pinyin>cai4</pinyin></item>
        
        <item><char>cān</char><pinyin>can1</pinyin></item>
        <item><char>cán</char><pinyin>can2</pinyin></item>
        <item><char>cǎn</char><pinyin>can3</pinyin></item>
        <item><char>càn</char><pinyin>can4</pinyin></item>
        
        <item><char>cāo</char><pinyin>cao1</pinyin></item>
        <item><char>cáo</char><pinyin>cao2</pinyin></item>
        <item><char>cǎo</char><pinyin>cao3</pinyin></item>
        <item><char>cào</char><pinyin>cao4</pinyin></item>
        
        <item><char>cā</char><pinyin>ca1</pinyin></item>
        <item><char>cá</char><pinyin>ca2</pinyin></item>
        <item><char>cǎ</char><pinyin>ca3</pinyin></item>
        <item><char>cà</char><pinyin>ca4</pinyin></item>
        
        <item><char>cēng</char><pinyin>ceng1</pinyin></item>
        <item><char>céng</char><pinyin>ceng2</pinyin></item>
        <item><char>cěng</char><pinyin>ceng3</pinyin></item>
        <item><char>cèng</char><pinyin>ceng4</pinyin></item>
        
        <item><char>cēi</char><pinyin>cei1</pinyin></item>
        <item><char>céi</char><pinyin>cei2</pinyin></item>
        <item><char>cěi</char><pinyin>cei3</pinyin></item>
        <item><char>cèi</char><pinyin>cei4</pinyin></item>
        
      	<item><char>cēn</char><pinyin>cen1</pinyin></item>
        <item><char>cén</char><pinyin>cen2</pinyin></item>
        <item><char>cěn</char><pinyin>cen3</pinyin></item>
        <item><char>cèn</char><pinyin>cen4</pinyin></item>
        
        <item><char>cē</char><pinyin>ce1</pinyin></item>
        <item><char>cé</char><pinyin>ce2</pinyin></item>
        <item><char>cě</char><pinyin>ce3</pinyin></item>
        <item><char>cè</char><pinyin>ce4</pinyin></item>
        
        <item><char>chā</char><pinyin>cha1</pinyin></item>
        <item><char>chá</char><pinyin>cha2</pinyin></item>
        <item><char>chǎ</char><pinyin>cha3</pinyin></item>
        <item><char>chà</char><pinyin>cha4</pinyin></item>
        
        <item><char>chēng</char><pinyin>cheng1</pinyin></item>
        <item><char>chéng</char><pinyin>cheng2</pinyin></item>
        <item><char>chěng</char><pinyin>cheng3</pinyin></item>
        <item><char>chèng</char><pinyin>cheng4</pinyin></item>
        
        <item><char>chēn</char><pinyin>chen1</pinyin></item>
        <item><char>chén</char><pinyin>chen2</pinyin></item>
        <item><char>chěn</char><pinyin>chen3</pinyin></item>
        <item><char>chèn</char><pinyin>chen4</pinyin></item>
        
        <item><char>chē</char><pinyin>che1</pinyin></item>
        <item><char>ché</char><pinyin>che2</pinyin></item>
        <item><char>chě</char><pinyin>che3</pinyin></item>
        <item><char>chè</char><pinyin>che4</pinyin></item>
        
      	<item><char>chī</char><pinyin>chi1</pinyin></item>
        <item><char>chí</char><pinyin>chi2</pinyin></item>
        <item><char>chǐ</char><pinyin>chi3</pinyin></item>
        <item><char>chì</char><pinyin>chi4</pinyin></item>
        
      	<item><char>chōng</char><pinyin>chong1</pinyin></item>
        <item><char>chóng</char><pinyin>chong2</pinyin></item>
        <item><char>chǒng</char><pinyin>chong3</pinyin></item>
        <item><char>chòng</char><pinyin>chong4</pinyin></item>
        
      	<item><char>chōu</char><pinyin>chou1</pinyin></item>
        <item><char>chóu</char><pinyin>chou2</pinyin></item>
        <item><char>chǒu</char><pinyin>chou3</pinyin></item>
        <item><char>chòu</char><pinyin>chou4</pinyin></item>
        
        <item><char>chuā</char><pinyin>chua1</pinyin></item>
        <item><char>chuá</char><pinyin>chua2</pinyin></item>
        <item><char>chuǎ</char><pinyin>chua3</pinyin></item>
        <item><char>chuà</char><pinyin>chua4</pinyin></item>
        
        <item><char>chuī</char><pinyin>chui1</pinyin></item>
        <item><char>chuí</char><pinyin>chui2</pinyin></item>
        <item><char>chuǐ</char><pinyin>chui3</pinyin></item>
        <item><char>chuì</char><pinyin>chui4</pinyin></item>
        
        <item><char>chūn</char><pinyin>chun1</pinyin></item>
        <item><char>chún</char><pinyin>chun2</pinyin></item>
        <item><char>chǔn</char><pinyin>chun3</pinyin></item>
        <item><char>chùn</char><pinyin>chun4</pinyin></item>
        
        <item><char>chuō</char><pinyin>chuo1</pinyin></item>
        <item><char>chuó</char><pinyin>chuo2</pinyin></item>
        <item><char>chuǒ</char><pinyin>chuo3</pinyin></item>
        <item><char>chuò</char><pinyin>chuo4</pinyin></item>
        
        <item><char>chū</char><pinyin>chu1</pinyin></item>
        <item><char>chú</char><pinyin>chu2</pinyin></item>
        <item><char>chǔ</char><pinyin>chu3</pinyin></item>
        <item><char>chù</char><pinyin>chu4</pinyin></item>
        
      	<item><char>cī</char><pinyin>ci1</pinyin></item>
        <item><char>cí</char><pinyin>ci2</pinyin></item>
        <item><char>cǐ</char><pinyin>ci3</pinyin></item>
        <item><char>cì</char><pinyin>ci4</pinyin></item>
        
      	<item><char>cōng</char><pinyin>cong1</pinyin></item>
        <item><char>cóng</char><pinyin>cong2</pinyin></item>
        <item><char>cǒng</char><pinyin>cong3</pinyin></item>
        <item><char>còng</char><pinyin>cong4</pinyin></item>
        
      	<item><char>cōu</char><pinyin>cou1</pinyin></item>
        <item><char>cóu</char><pinyin>cou2</pinyin></item>
        <item><char>cǒu</char><pinyin>cou3</pinyin></item>
        <item><char>còu</char><pinyin>cou4</pinyin></item>
        
        <item><char>cuān</char><pinyin>cuan1</pinyin></item>
        <item><char>cuán</char><pinyin>cuan2</pinyin></item>
        <item><char>cuǎn</char><pinyin>cuan3</pinyin></item>
        <item><char>cuàn</char><pinyin>cuan4</pinyin></item>
        
        <item><char>cuī</char><pinyin>cui1</pinyin></item>
        <item><char>cuí</char><pinyin>cui2</pinyin></item>
        <item><char>cuǐ</char><pinyin>cui3</pinyin></item>
        <item><char>cuì</char><pinyin>cui4</pinyin></item>
        
        <item><char>cūn</char><pinyin>cun1</pinyin></item>
        <item><char>cún</char><pinyin>cun2</pinyin></item>
        <item><char>cǔn</char><pinyin>cun3</pinyin></item>
        <item><char>cùn</char><pinyin>cun4</pinyin></item>
        
        <item><char>cuō</char><pinyin>cuo1</pinyin></item>
        <item><char>cuó</char><pinyin>cuo2</pinyin></item>
        <item><char>cuǒ</char><pinyin>cuo3</pinyin></item>
        <item><char>cuò</char><pinyin>cuo4</pinyin></item>
        
        <item><char>cū</char><pinyin>cu1</pinyin></item>
        <item><char>cú</char><pinyin>cu2</pinyin></item>
        <item><char>cǔ</char><pinyin>cu3</pinyin></item>
        <item><char>cù</char><pinyin>cu4</pinyin></item>
        
      </group>
      <group key="d">
        
      	<item><char>dāi</char><pinyin>dai1</pinyin></item>
        <item><char>dái</char><pinyin>dai2</pinyin></item>
        <item><char>dǎi</char><pinyin>dai3</pinyin></item>
        <item><char>dài</char><pinyin>dai4</pinyin></item>
        
        <item><char>dāng</char><pinyin>dang1</pinyin></item>
        <item><char>dáng</char><pinyin>dang2</pinyin></item>
        <item><char>dǎng</char><pinyin>dang3</pinyin></item>
        <item><char>dàng</char><pinyin>dang4</pinyin></item>
        
        <item><char>dān</char><pinyin>dan1</pinyin></item>
        <item><char>dán</char><pinyin>dan2</pinyin></item>
        <item><char>dǎn</char><pinyin>dan3</pinyin></item>
        <item><char>dàn</char><pinyin>dan4</pinyin></item>
        
      	<item><char>dāo</char><pinyin>dao1</pinyin></item>
        <item><char>dáo</char><pinyin>dao2</pinyin></item>
        <item><char>dǎo</char><pinyin>dao3</pinyin></item>
        <item><char>dào</char><pinyin>dao4</pinyin></item>
        
        <item><char>dā</char><pinyin>da1</pinyin></item>
        <item><char>dá</char><pinyin>da2</pinyin></item>
        <item><char>dǎ</char><pinyin>da3</pinyin></item>
        <item><char>dà</char><pinyin>da4</pinyin></item>
        
        <item><char>dēng</char><pinyin>deng1</pinyin></item>
        <item><char>déng</char><pinyin>deng2</pinyin></item>
        <item><char>děng</char><pinyin>deng3</pinyin></item>
        <item><char>dèng</char><pinyin>deng4</pinyin></item>
        
      	<item><char>dēi</char><pinyin>dei1</pinyin></item>
        <item><char>déi</char><pinyin>dei2</pinyin></item>
        <item><char>děi</char><pinyin>dei3</pinyin></item>
        <item><char>dèi</char><pinyin>dei4</pinyin></item>
        
      	<item><char>dēn</char><pinyin>den1</pinyin></item>
        <item><char>dén</char><pinyin>den2</pinyin></item>
        <item><char>děn</char><pinyin>den3</pinyin></item>
        <item><char>dèn</char><pinyin>den4</pinyin></item>
        
        <item><char>dē</char><pinyin>de1</pinyin></item>
        <item><char>dé</char><pinyin>de2</pinyin></item>
        <item><char>dě</char><pinyin>de3</pinyin></item>
        <item><char>dè</char><pinyin>de4</pinyin></item>
        
      	<item><char>diān</char><pinyin>dian1</pinyin></item>
        <item><char>dián</char><pinyin>dian2</pinyin></item>
        <item><char>diǎn</char><pinyin>dian3</pinyin></item>
        <item><char>diàn</char><pinyin>dian4</pinyin></item>
        
      	<item><char>diāo</char><pinyin>diao1</pinyin></item>
        <item><char>diáo</char><pinyin>diao2</pinyin></item>
        <item><char>diǎo</char><pinyin>diao3</pinyin></item>
        <item><char>diào</char><pinyin>diao4</pinyin></item>
        
      	<item><char>diē</char><pinyin>die1</pinyin></item>
        <item><char>dié</char><pinyin>die2</pinyin></item>
        <item><char>diě</char><pinyin>die3</pinyin></item>
        <item><char>diè</char><pinyin>die4</pinyin></item>
        
      	<item><char>dīng</char><pinyin>ding1</pinyin></item>
        <item><char>díng</char><pinyin>ding2</pinyin></item>
        <item><char>dǐng</char><pinyin>ding3</pinyin></item>
        <item><char>dìng</char><pinyin>ding4</pinyin></item>
        
      	<item><char>dīu</char><pinyin>diu1</pinyin></item>
        <item><char>díu</char><pinyin>diu2</pinyin></item>
        <item><char>dǐu</char><pinyin>diu3</pinyin></item>
        <item><char>dìu</char><pinyin>diu4</pinyin></item>
        
        <item><char>dī</char><pinyin>di1</pinyin></item>
        <item><char>dí</char><pinyin>di2</pinyin></item>
        <item><char>dǐ</char><pinyin>di3</pinyin></item>
        <item><char>dì</char><pinyin>di4</pinyin></item>
        
        <item><char>dōng</char><pinyin>dong1</pinyin></item>
        <item><char>dóng</char><pinyin>dong2</pinyin></item>
        <item><char>dǒng</char><pinyin>dong3</pinyin></item>
        <item><char>dòng</char><pinyin>dong4</pinyin></item>
        
      	<item><char>dōu</char><pinyin>dou1</pinyin></item>
        <item><char>dóu</char><pinyin>dou2</pinyin></item>
        <item><char>dǒu</char><pinyin>dou3</pinyin></item>
        <item><char>dòu</char><pinyin>dou4</pinyin></item>
        
      	<item><char>duān</char><pinyin>duan1</pinyin></item>
        <item><char>duán</char><pinyin>duan2</pinyin></item>
        <item><char>duǎn</char><pinyin>duan3</pinyin></item>
        <item><char>duàn</char><pinyin>duan4</pinyin></item>
        
      	<item><char>duī</char><pinyin>dui1</pinyin></item>
        <item><char>duí</char><pinyin>dui2</pinyin></item>
        <item><char>duǐ</char><pinyin>dui3</pinyin></item>
        <item><char>duì</char><pinyin>dui4</pinyin></item>
        
      	<item><char>dūn</char><pinyin>dun1</pinyin></item>
        <item><char>dún</char><pinyin>dun2</pinyin></item>
        <item><char>dǔn</char><pinyin>dun3</pinyin></item>
        <item><char>dùn</char><pinyin>dun4</pinyin></item>
        
      	<item><char>duō</char><pinyin>duo1</pinyin></item>
        <item><char>duó</char><pinyin>duo2</pinyin></item>
        <item><char>duǒ</char><pinyin>duo3</pinyin></item>
        <item><char>duò</char><pinyin>duo4</pinyin></item>
      
        <item><char>dū</char><pinyin>du1</pinyin></item>
        <item><char>dú</char><pinyin>du2</pinyin></item>
        <item><char>dǔ</char><pinyin>du3</pinyin></item>
        <item><char>dù</char><pinyin>du4</pinyin></item>
        
      </group>
      <group key="e">
      	<item><char>ēi</char><pinyin>ei1</pinyin></item>
        <item><char>éi</char><pinyin>ei2</pinyin></item>
        <item><char>ěi</char><pinyin>ei3</pinyin></item>
        <item><char>èi</char><pinyin>ei4</pinyin></item>
        
      	<item><char>ēng</char><pinyin>eng1</pinyin></item>
        <item><char>éng</char><pinyin>eng2</pinyin></item>
        <item><char>ěng</char><pinyin>eng3</pinyin></item>
        <item><char>èng</char><pinyin>eng4</pinyin></item>
        
        <item><char>ēn</char><pinyin>en1</pinyin></item>
        <item><char>én</char><pinyin>en2</pinyin></item>
        <item><char>ěn</char><pinyin>en3</pinyin></item>
        <item><char>èn</char><pinyin>en4</pinyin></item>
        
        <item><char>ēr</char><pinyin>er1</pinyin></item>
        <item><char>ér</char><pinyin>er2</pinyin></item>
        <item><char>ěr</char><pinyin>er3</pinyin></item>
        <item><char>èr</char><pinyin>er4</pinyin></item>

        <item><char>ē</char><pinyin>e1</pinyin></item>
        <item><char>é</char><pinyin>e2</pinyin></item>
        <item><char>ě</char><pinyin>e3</pinyin></item>
        <item><char>è</char><pinyin>e4</pinyin></item>
        
      </group>
      <group key="f">
        
      	<item><char>fān</char><pinyin>fan1</pinyin></item>
        <item><char>fán</char><pinyin>fan2</pinyin></item>
        <item><char>fǎn</char><pinyin>fan3</pinyin></item>
        <item><char>fàn</char><pinyin>fan4</pinyin></item>
        
      	<item><char>fāng</char><pinyin>fang1</pinyin></item>
        <item><char>fáng</char><pinyin>fang2</pinyin></item>
        <item><char>fǎng</char><pinyin>fang3</pinyin></item>
        <item><char>fàng</char><pinyin>fang4</pinyin></item>
      
        <item><char>fā</char><pinyin>fa1</pinyin></item>
        <item><char>fá</char><pinyin>fa2</pinyin></item>
        <item><char>fǎ</char><pinyin>fa3</pinyin></item>
        <item><char>fà</char><pinyin>fa4</pinyin></item>
        
        <item><char>fēng</char><pinyin>feng1</pinyin></item>
        <item><char>féng</char><pinyin>feng2</pinyin></item>
        <item><char>fěng</char><pinyin>feng3</pinyin></item>
        <item><char>fèng</char><pinyin>feng4</pinyin></item>
        
        <item><char>fēi</char><pinyin>fei1</pinyin></item>
        <item><char>féi</char><pinyin>fei2</pinyin></item>
        <item><char>fěi</char><pinyin>fei3</pinyin></item>
        <item><char>fèi</char><pinyin>fei4</pinyin></item>
        
      	<item><char>fēn</char><pinyin>fen1</pinyin></item>
        <item><char>fén</char><pinyin>fen2</pinyin></item>
        <item><char>fěn</char><pinyin>fen3</pinyin></item>
        <item><char>fèn</char><pinyin>fen4</pinyin></item>
        
      	<item><char>fōu</char><pinyin>fou1</pinyin></item>
        <item><char>fóu</char><pinyin>fou2</pinyin></item>
        <item><char>fǒu</char><pinyin>fou3</pinyin></item>
        <item><char>fòu</char><pinyin>fou4</pinyin></item>
        
        <item><char>fō</char><pinyin>fo1</pinyin></item>
        <item><char>fó</char><pinyin>fo2</pinyin></item>
        <item><char>fǒ</char><pinyin>fo3</pinyin></item>
        <item><char>fò</char><pinyin>fo4</pinyin></item>
        
        <item><char>fū</char><pinyin>fu1</pinyin></item>
        <item><char>fú</char><pinyin>fu2</pinyin></item>
        <item><char>fǔ</char><pinyin>fu3</pinyin></item>
        <item><char>fù</char><pinyin>fu4</pinyin></item>
      </group>
      <group key="g">
        
      	<item><char>gāi</char><pinyin>gai1</pinyin></item>
        <item><char>gái</char><pinyin>gai2</pinyin></item>
        <item><char>gǎi</char><pinyin>gai3</pinyin></item>
        <item><char>gài</char><pinyin>gai4</pinyin></item>
        
        <item><char>gāng</char><pinyin>gang1</pinyin></item>
        <item><char>gáng</char><pinyin>gang2</pinyin></item>
        <item><char>gǎng</char><pinyin>gang3</pinyin></item>
        <item><char>gàng</char><pinyin>gang4</pinyin></item>
        
        <item><char>gān</char><pinyin>gan1</pinyin></item>
        <item><char>gán</char><pinyin>gan2</pinyin></item>
        <item><char>gǎn</char><pinyin>gan3</pinyin></item>
        <item><char>gàn</char><pinyin>gan4</pinyin></item>
        
      	<item><char>gāo</char><pinyin>gao1</pinyin></item>
        <item><char>gáo</char><pinyin>gao2</pinyin></item>
        <item><char>gǎo</char><pinyin>gao3</pinyin></item>
        <item><char>gào</char><pinyin>gao4</pinyin></item>
        
        <item><char>gā</char><pinyin>ga1</pinyin></item>
        <item><char>gá</char><pinyin>ga2</pinyin></item>
        <item><char>gǎ</char><pinyin>ga3</pinyin></item>
        <item><char>gà</char><pinyin>ga4</pinyin></item>
        
        <item><char>gē</char><pinyin>ge1</pinyin></item>
        <item><char>gé</char><pinyin>ge2</pinyin></item>
        <item><char>gě</char><pinyin>ge3</pinyin></item>
        <item><char>gè</char><pinyin>ge4</pinyin></item>
        
      	<item><char>gēi</char><pinyin>gei1</pinyin></item>
        <item><char>géi</char><pinyin>gei2</pinyin></item>
        <item><char>gěi</char><pinyin>gei3</pinyin></item>
        <item><char>gèi</char><pinyin>gei4</pinyin></item>
        
        <item><char>gēng</char><pinyin>geng1</pinyin></item>
        <item><char>géng</char><pinyin>geng2</pinyin></item>
        <item><char>gěng</char><pinyin>geng3</pinyin></item>
        <item><char>gèng</char><pinyin>geng4</pinyin></item>
        
        <item><char>gēn</char><pinyin>gen1</pinyin></item>
        <item><char>gén</char><pinyin>gen2</pinyin></item>
        <item><char>gěn</char><pinyin>gen3</pinyin></item>
        <item><char>gèn</char><pinyin>gen4</pinyin></item>
        
      	<item><char>gōng</char><pinyin>gong1</pinyin></item>
        <item><char>góng</char><pinyin>gong2</pinyin></item>
        <item><char>gǒng</char><pinyin>gong3</pinyin></item>
        <item><char>gòng</char><pinyin>gong4</pinyin></item>
        
      	<item><char>gōu</char><pinyin>gou1</pinyin></item>
        <item><char>góu</char><pinyin>gou2</pinyin></item>
        <item><char>gǒu</char><pinyin>gou3</pinyin></item>
        <item><char>gòu</char><pinyin>gou4</pinyin></item>
        
        <item><char>guāi</char><pinyin>guai1</pinyin></item>
        <item><char>guái</char><pinyin>guai2</pinyin></item>
        <item><char>guǎi</char><pinyin>guai3</pinyin></item>
        <item><char>guài</char><pinyin>guai4</pinyin></item>
        
        <item><char>guā</char><pinyin>gua1</pinyin></item>
        <item><char>guá</char><pinyin>gua2</pinyin></item>
        <item><char>guǎ</char><pinyin>gua3</pinyin></item>
        <item><char>guà</char><pinyin>gua4</pinyin></item>
        
        <item><char>guāng</char><pinyin>guang1</pinyin></item>
        <item><char>guáng</char><pinyin>guang2</pinyin></item>
        <item><char>guǎng</char><pinyin>guang3</pinyin></item>
        <item><char>guàng</char><pinyin>guang4</pinyin></item>
        
        <item><char>guān</char><pinyin>guan1</pinyin></item>
        <item><char>guán</char><pinyin>guan2</pinyin></item>
        <item><char>guǎn</char><pinyin>guan3</pinyin></item>
        <item><char>guàn</char><pinyin>guan4</pinyin></item>
        
      	<item><char>guī</char><pinyin>gui1</pinyin></item>
        <item><char>guí</char><pinyin>gui2</pinyin></item>
        <item><char>guǐ</char><pinyin>gui3</pinyin></item>
        <item><char>guì</char><pinyin>gui4</pinyin></item>
        
      	<item><char>gūn</char><pinyin>gun1</pinyin></item>
        <item><char>gún</char><pinyin>gun2</pinyin></item>
        <item><char>gǔn</char><pinyin>gun3</pinyin></item>
        <item><char>gùn</char><pinyin>gun4</pinyin></item>
        
      	<item><char>guō</char><pinyin>guo1</pinyin></item>
        <item><char>guó</char><pinyin>guo2</pinyin></item>
        <item><char>guǒ</char><pinyin>guo3</pinyin></item>
        <item><char>guò</char><pinyin>guo4</pinyin></item>

        <item><char>gū</char><pinyin>gu1</pinyin></item>
        <item><char>gú</char><pinyin>gu2</pinyin></item>
        <item><char>gǔ</char><pinyin>gu3</pinyin></item>
        <item><char>gù</char><pinyin>gu4</pinyin></item>
        
      </group>
      <group key="h">
      
      	<item><char>hāi</char><pinyin>hai1</pinyin></item>
        <item><char>hái</char><pinyin>hai2</pinyin></item>
        <item><char>hǎi</char><pinyin>hai3</pinyin></item>
        <item><char>hài</char><pinyin>hai4</pinyin></item>
        
        <item><char>hāng</char><pinyin>hang1</pinyin></item>
        <item><char>háng</char><pinyin>hang2</pinyin></item>
        <item><char>hǎng</char><pinyin>hang3</pinyin></item>
        <item><char>hàng</char><pinyin>hang4</pinyin></item>
        
        <item><char>hān</char><pinyin>han1</pinyin></item>
        <item><char>hán</char><pinyin>han2</pinyin></item>
        <item><char>hǎn</char><pinyin>han3</pinyin></item>
        <item><char>hàn</char><pinyin>han4</pinyin></item>
        
      	<item><char>hāo</char><pinyin>hao1</pinyin></item>
        <item><char>háo</char><pinyin>hao2</pinyin></item>
        <item><char>hǎo</char><pinyin>hao3</pinyin></item>
        <item><char>hào</char><pinyin>hao4</pinyin></item>
        
        <item><char>hā</char><pinyin>ha1</pinyin></item>
        <item><char>há</char><pinyin>ha2</pinyin></item>
        <item><char>hǎ</char><pinyin>ha3</pinyin></item>
        <item><char>hà</char><pinyin>ha4</pinyin></item>
        
      	<item><char>hēi</char><pinyin>hei1</pinyin></item>
        <item><char>héi</char><pinyin>hei2</pinyin></item>
        <item><char>hěi</char><pinyin>hei3</pinyin></item>
        <item><char>hèi</char><pinyin>hei4</pinyin></item>
        
        <item><char>hēng</char><pinyin>heng1</pinyin></item>
        <item><char>héng</char><pinyin>heng2</pinyin></item>
        <item><char>hěng</char><pinyin>heng3</pinyin></item>
        <item><char>hèng</char><pinyin>heng4</pinyin></item>
        
        <item><char>hēn</char><pinyin>hen1</pinyin></item>
        <item><char>hén</char><pinyin>hen2</pinyin></item>
        <item><char>hěn</char><pinyin>hen3</pinyin></item>
        <item><char>hèn</char><pinyin>hen4</pinyin></item>
        
        <item><char>hē</char><pinyin>he1</pinyin></item>
        <item><char>hé</char><pinyin>he2</pinyin></item>
        <item><char>hě</char><pinyin>he3</pinyin></item>
        <item><char>hè</char><pinyin>he4</pinyin></item>
        
        <item><char>hōng</char><pinyin>hong1</pinyin></item>
        <item><char>hóng</char><pinyin>hong2</pinyin></item>
        <item><char>hǒng</char><pinyin>hong3</pinyin></item>
        <item><char>hòng</char><pinyin>hong4</pinyin></item>
        
      	<item><char>hōu</char><pinyin>hou1</pinyin></item>
        <item><char>hóu</char><pinyin>hou2</pinyin></item>
        <item><char>hǒu</char><pinyin>hou3</pinyin></item>
        <item><char>hòu</char><pinyin>hou4</pinyin></item>
        
        <item><char>huāi</char><pinyin>huai1</pinyin></item>
        <item><char>huái</char><pinyin>huai2</pinyin></item>
        <item><char>huǎi</char><pinyin>huai3</pinyin></item>
        <item><char>huài</char><pinyin>huai4</pinyin></item>
        
        <item><char>huā</char><pinyin>hua1</pinyin></item>
        <item><char>huá</char><pinyin>hua2</pinyin></item>
        <item><char>huǎ</char><pinyin>hua3</pinyin></item>
        <item><char>huà</char><pinyin>hua4</pinyin></item>
        
        <item><char>huāng</char><pinyin>huang1</pinyin></item>
        <item><char>huáng</char><pinyin>huang2</pinyin></item>
        <item><char>huǎng</char><pinyin>huang3</pinyin></item>
        <item><char>huàng</char><pinyin>huang4</pinyin></item>
        
        <item><char>huān</char><pinyin>huan1</pinyin></item>
        <item><char>huán</char><pinyin>huan2</pinyin></item>
        <item><char>huǎn</char><pinyin>huan3</pinyin></item>
        <item><char>huàn</char><pinyin>huan4</pinyin></item>
        
      	<item><char>huī</char><pinyin>hui1</pinyin></item>
        <item><char>huí</char><pinyin>hui2</pinyin></item>
        <item><char>huǐ</char><pinyin>hui3</pinyin></item>
        <item><char>huì</char><pinyin>hui4</pinyin></item>
        
      	<item><char>hūn</char><pinyin>hun1</pinyin></item>
        <item><char>hún</char><pinyin>hun2</pinyin></item>
        <item><char>hǔn</char><pinyin>hun3</pinyin></item>
        <item><char>hùn</char><pinyin>hun4</pinyin></item>
        
      	<item><char>huō</char><pinyin>huo1</pinyin></item>
        <item><char>huó</char><pinyin>huo2</pinyin></item>
        <item><char>huǒ</char><pinyin>huo3</pinyin></item>
        <item><char>huò</char><pinyin>huo4</pinyin></item>
        
        <item><char>hū</char><pinyin>hu1</pinyin></item>
        <item><char>hú</char><pinyin>hu2</pinyin></item>
        <item><char>hǔ</char><pinyin>hu3</pinyin></item>
        <item><char>hù</char><pinyin>hu4</pinyin></item>
        
      </group>
      <group key="j">
        
        <item><char>jiāng</char><pinyin>jiang1</pinyin></item>
        <item><char>jiáng</char><pinyin>jiang2</pinyin></item>
        <item><char>jiǎng</char><pinyin>jiang3</pinyin></item>
        <item><char>jiàng</char><pinyin>jiang4</pinyin></item>
        
        <item><char>jiān</char><pinyin>jian1</pinyin></item>
        <item><char>jián</char><pinyin>jian2</pinyin></item>
        <item><char>jiǎn</char><pinyin>jian3</pinyin></item>
        <item><char>jiàn</char><pinyin>jian4</pinyin></item>
        
        <item><char>jiā</char><pinyin>jia1</pinyin></item>
        <item><char>jiá</char><pinyin>jia2</pinyin></item>
        <item><char>jiǎ</char><pinyin>jia3</pinyin></item>
        <item><char>jià</char><pinyin>jia4</pinyin></item>
        
      	<item><char>jiāo</char><pinyin>jiao1</pinyin></item>
        <item><char>jiáo</char><pinyin>jiao2</pinyin></item>
        <item><char>jiǎo</char><pinyin>jiao3</pinyin></item>
        <item><char>jiào</char><pinyin>jiao4</pinyin></item>
        
      	<item><char>jiē</char><pinyin>jie1</pinyin></item>
        <item><char>jié</char><pinyin>jie2</pinyin></item>
        <item><char>jiě</char><pinyin>jie3</pinyin></item>
        <item><char>jiè</char><pinyin>jie4</pinyin></item>
        
        <item><char>jīng</char><pinyin>jing1</pinyin></item>
        <item><char>jíng</char><pinyin>jing2</pinyin></item>
        <item><char>jǐng</char><pinyin>jing3</pinyin></item>
        <item><char>jìng</char><pinyin>jing4</pinyin></item>
        
        <item><char>jīn</char><pinyin>jin1</pinyin></item>
        <item><char>jín</char><pinyin>jin2</pinyin></item>
        <item><char>jǐn</char><pinyin>jin3</pinyin></item>
        <item><char>jìn</char><pinyin>jin4</pinyin></item>
        
      	<item><char>jīong</char><pinyin>jiong1</pinyin></item>
        <item><char>jíong</char><pinyin>jiong2</pinyin></item>
        <item><char>jǐong</char><pinyin>jiong3</pinyin></item>
        <item><char>jìong</char><pinyin>jiong4</pinyin></item>
        
      	<item><char>jīu</char><pinyin>jiu1</pinyin></item>
        <item><char>jíu</char><pinyin>jiu2</pinyin></item>
        <item><char>jǐu</char><pinyin>jiu3</pinyin></item>
        <item><char>jìu</char><pinyin>jiu4</pinyin></item>
        
        <item><char>jī</char><pinyin>ji1</pinyin></item>
        <item><char>jí</char><pinyin>ji2</pinyin></item>
        <item><char>jǐ</char><pinyin>ji3</pinyin></item>
        <item><char>jì</char><pinyin>ji4</pinyin></item>
        
      	<item><char>juān</char><pinyin>juan1</pinyin></item>
        <item><char>juán</char><pinyin>juan2</pinyin></item>
        <item><char>juǎn</char><pinyin>juan3</pinyin></item>
        <item><char>juàn</char><pinyin>juan4</pinyin></item>
        
      	<item><char>juē</char><pinyin>jue1</pinyin></item>
        <item><char>jué</char><pinyin>jue2</pinyin></item>
        <item><char>juě</char><pinyin>jue3</pinyin></item>
        <item><char>juè</char><pinyin>jue4</pinyin></item>
        
      	<item><char>jūn</char><pinyin>jun1</pinyin></item>
        <item><char>jún</char><pinyin>jun2</pinyin></item>
        <item><char>jǔn</char><pinyin>jun3</pinyin></item>
        <item><char>jùn</char><pinyin>jun4</pinyin></item>

        <item><char>jū</char><pinyin>ju1</pinyin></item>
        <item><char>jú</char><pinyin>ju2</pinyin></item>
        <item><char>jǔ</char><pinyin>ju3</pinyin></item>
        <item><char>jù</char><pinyin>ju4</pinyin></item>
        
      </group>
      <group key="k">
        
      	<item><char>kāi</char><pinyin>kai1</pinyin></item>
        <item><char>kái</char><pinyin>kai2</pinyin></item>
        <item><char>kǎi</char><pinyin>kai3</pinyin></item>
        <item><char>kài</char><pinyin>kai4</pinyin></item>
        
        <item><char>kāng</char><pinyin>kang1</pinyin></item>
        <item><char>káng</char><pinyin>kang2</pinyin></item>
        <item><char>kǎng</char><pinyin>kang3</pinyin></item>
        <item><char>kàng</char><pinyin>kang4</pinyin></item>
        
        <item><char>kān</char><pinyin>kan1</pinyin></item>
        <item><char>kán</char><pinyin>kan2</pinyin></item>
        <item><char>kǎn</char><pinyin>kan3</pinyin></item>
        <item><char>kàn</char><pinyin>kan4</pinyin></item>
        
      	<item><char>kāo</char><pinyin>kao1</pinyin></item>
        <item><char>káo</char><pinyin>kao2</pinyin></item>
        <item><char>kǎo</char><pinyin>kao3</pinyin></item>
        <item><char>kào</char><pinyin>kao4</pinyin></item>
        
        <item><char>kā</char><pinyin>ka1</pinyin></item>
        <item><char>ká</char><pinyin>ka2</pinyin></item>
        <item><char>kǎ</char><pinyin>ka3</pinyin></item>
        <item><char>kà</char><pinyin>ka4</pinyin></item>
        
      	<item><char>kēi</char><pinyin>kei1</pinyin></item>
        <item><char>kéi</char><pinyin>kei2</pinyin></item>
        <item><char>kěi</char><pinyin>kei3</pinyin></item>
        <item><char>kèi</char><pinyin>kei4</pinyin></item>
        
      	<item><char>kēng</char><pinyin>keng1</pinyin></item>
        <item><char>kéng</char><pinyin>keng2</pinyin></item>
        <item><char>kěng</char><pinyin>keng3</pinyin></item>
        <item><char>kèng</char><pinyin>keng4</pinyin></item>
        
        <item><char>kēn</char><pinyin>ken1</pinyin></item>
        <item><char>kén</char><pinyin>ken2</pinyin></item>
        <item><char>kěn</char><pinyin>ken3</pinyin></item>
        <item><char>kèn</char><pinyin>ken4</pinyin></item>
        
        <item><char>kē</char><pinyin>ke1</pinyin></item>
        <item><char>ké</char><pinyin>ke2</pinyin></item>
        <item><char>kě</char><pinyin>ke3</pinyin></item>
        <item><char>kè</char><pinyin>ke4</pinyin></item>
        
        <item><char>kōng</char><pinyin>kong1</pinyin></item>
        <item><char>kóng</char><pinyin>kong2</pinyin></item>
        <item><char>kǒng</char><pinyin>kong3</pinyin></item>
        <item><char>kòng</char><pinyin>kong4</pinyin></item>
        
      	<item><char>kōu</char><pinyin>kou1</pinyin></item>
        <item><char>kóu</char><pinyin>kou2</pinyin></item>
        <item><char>kǒu</char><pinyin>kou3</pinyin></item>
        <item><char>kòu</char><pinyin>kou4</pinyin></item>
        
      	<item><char>kuāi</char><pinyin>kuai1</pinyin></item>
        <item><char>kuái</char><pinyin>kuai2</pinyin></item>
        <item><char>kuǎi</char><pinyin>kuai3</pinyin></item>
        <item><char>kuài</char><pinyin>kuai4</pinyin></item>
        
        <item><char>kuāng</char><pinyin>kuang1</pinyin></item>
        <item><char>kuáng</char><pinyin>kuang2</pinyin></item>
        <item><char>kuǎng</char><pinyin>kuang3</pinyin></item>
        <item><char>kuàng</char><pinyin>kuang4</pinyin></item>
        
        <item><char>kuān</char><pinyin>kuan1</pinyin></item>
        <item><char>kuán</char><pinyin>kuan2</pinyin></item>
        <item><char>kuǎn</char><pinyin>kuan3</pinyin></item>
        <item><char>kuàn</char><pinyin>kuan4</pinyin></item>
        
        <item><char>kuā</char><pinyin>kua1</pinyin></item>
        <item><char>kuá</char><pinyin>kua2</pinyin></item>
        <item><char>kuǎ</char><pinyin>kua3</pinyin></item>
        <item><char>kuà</char><pinyin>kua4</pinyin></item>
        
        <item><char>kuī</char><pinyin>kui1</pinyin></item>
        <item><char>kuí</char><pinyin>kui2</pinyin></item>
        <item><char>kuǐ</char><pinyin>kui3</pinyin></item>
        <item><char>kuì</char><pinyin>kui4</pinyin></item>
        
      	<item><char>kūn</char><pinyin>kun1</pinyin></item>
        <item><char>kún</char><pinyin>kun2</pinyin></item>
        <item><char>kǔn</char><pinyin>kun3</pinyin></item>
        <item><char>kùn</char><pinyin>kun4</pinyin></item>
        
      	<item><char>kuō</char><pinyin>kuo1</pinyin></item>
        <item><char>kuó</char><pinyin>kuo2</pinyin></item>
        <item><char>kuǒ</char><pinyin>kuo3</pinyin></item>
        <item><char>kuò</char><pinyin>kuo4</pinyin></item>

        <item><char>kū</char><pinyin>ku1</pinyin></item>
        <item><char>kú</char><pinyin>ku2</pinyin></item>
        <item><char>kǔ</char><pinyin>ku3</pinyin></item>
        <item><char>kù</char><pinyin>ku4</pinyin></item>
        
      </group>
      <group key="l">
        
      	<item><char>lāi</char><pinyin>lai1</pinyin></item>
        <item><char>lái</char><pinyin>lai2</pinyin></item>
        <item><char>lǎi</char><pinyin>lai3</pinyin></item>
        <item><char>lài</char><pinyin>lai4</pinyin></item>
        
        <item><char>lāng</char><pinyin>lang1</pinyin></item>
        <item><char>láng</char><pinyin>lang2</pinyin></item>
        <item><char>lǎng</char><pinyin>lang3</pinyin></item>
        <item><char>làng</char><pinyin>lang4</pinyin></item>
        
        <item><char>lān</char><pinyin>lan1</pinyin></item>
        <item><char>lán</char><pinyin>lan2</pinyin></item>
        <item><char>lǎn</char><pinyin>lan3</pinyin></item>
        <item><char>làn</char><pinyin>lan4</pinyin></item>
        
      	<item><char>lāo</char><pinyin>lao1</pinyin></item>
        <item><char>láo</char><pinyin>lao2</pinyin></item>
        <item><char>lǎo</char><pinyin>lao3</pinyin></item>
        <item><char>lào</char><pinyin>lao4</pinyin></item>
        
        <item><char>lā</char><pinyin>la1</pinyin></item>
        <item><char>lá</char><pinyin>la2</pinyin></item>
        <item><char>lǎ</char><pinyin>la3</pinyin></item>
        <item><char>là</char><pinyin>la4</pinyin></item>
        
      	<item><char>lēi</char><pinyin>lei1</pinyin></item>
        <item><char>léi</char><pinyin>lei2</pinyin></item>
        <item><char>lěi</char><pinyin>lei3</pinyin></item>
        <item><char>lèi</char><pinyin>lei4</pinyin></item>
        
      	<item><char>lēng</char><pinyin>leng1</pinyin></item>
        <item><char>léng</char><pinyin>leng2</pinyin></item>
        <item><char>lěng</char><pinyin>leng3</pinyin></item>
        <item><char>lèng</char><pinyin>leng4</pinyin></item>
        
        <item><char>lē</char><pinyin>le1</pinyin></item>
        <item><char>lé</char><pinyin>le2</pinyin></item>
        <item><char>lě</char><pinyin>le3</pinyin></item>
        <item><char>lè</char><pinyin>le4</pinyin></item>
        
      	<item><char>liāng</char><pinyin>liang1</pinyin></item>
        <item><char>liáng</char><pinyin>liang2</pinyin></item>
        <item><char>liǎng</char><pinyin>liang3</pinyin></item>
        <item><char>liàng</char><pinyin>liang4</pinyin></item>
        
        <item><char>liān</char><pinyin>lian1</pinyin></item>
        <item><char>lián</char><pinyin>lian2</pinyin></item>
        <item><char>liǎn</char><pinyin>lian3</pinyin></item>
        <item><char>liàn</char><pinyin>lian4</pinyin></item>
        
        <item><char>liāo</char><pinyin>liao1</pinyin></item>
        <item><char>liáo</char><pinyin>liao2</pinyin></item>
        <item><char>liǎo</char><pinyin>liao3</pinyin></item>
        <item><char>liào</char><pinyin>liao4</pinyin></item>
        
        <item><char>liā</char><pinyin>lia1</pinyin></item>
        <item><char>liá</char><pinyin>lia2</pinyin></item>
        <item><char>liǎ</char><pinyin>lia3</pinyin></item>
        <item><char>lià</char><pinyin>lia4</pinyin></item>
        
        <item><char>liē</char><pinyin>lie1</pinyin></item>
        <item><char>lié</char><pinyin>lie2</pinyin></item>
        <item><char>liě</char><pinyin>lie3</pinyin></item>
        <item><char>liè</char><pinyin>lie4</pinyin></item>
        
        <item><char>līng</char><pinyin>ling1</pinyin></item>
        <item><char>líng</char><pinyin>ling2</pinyin></item>
        <item><char>lǐng</char><pinyin>ling3</pinyin></item>
        <item><char>lìng</char><pinyin>ling4</pinyin></item>
        
        <item><char>līn</char><pinyin>lin1</pinyin></item>
        <item><char>lín</char><pinyin>lin2</pinyin></item>
        <item><char>lǐn</char><pinyin>lin3</pinyin></item>
        <item><char>lìn</char><pinyin>lin4</pinyin></item>
        
      	<item><char>līu</char><pinyin>liu1</pinyin></item>
        <item><char>líu</char><pinyin>liu2</pinyin></item>
        <item><char>lǐu</char><pinyin>liu3</pinyin></item>
        <item><char>lìu</char><pinyin>liu4</pinyin></item>
        
        <item><char>lī</char><pinyin>li1</pinyin></item>
        <item><char>lí</char><pinyin>li2</pinyin></item>
        <item><char>lǐ</char><pinyin>li3</pinyin></item>
        <item><char>lì</char><pinyin>li4</pinyin></item>
        
      	<item><char>lōng</char><pinyin>long1</pinyin></item>
        <item><char>lóng</char><pinyin>long2</pinyin></item>
        <item><char>lǒng</char><pinyin>long3</pinyin></item>
        <item><char>lòng</char><pinyin>long4</pinyin></item>
        
      	<item><char>lōu</char><pinyin>lou1</pinyin></item>
        <item><char>lóu</char><pinyin>lou2</pinyin></item>
        <item><char>lǒu</char><pinyin>lou3</pinyin></item>
        <item><char>lòu</char><pinyin>lou4</pinyin></item>
        
        <item><char>lō</char><pinyin>lo1</pinyin></item>
        <item><char>ló</char><pinyin>lo2</pinyin></item>
        <item><char>lǒ</char><pinyin>lo3</pinyin></item>
        <item><char>lò</char><pinyin>lo4</pinyin></item>
        
        <item><char>lū</char><pinyin>lu1</pinyin></item>
        <item><char>lú</char><pinyin>lu2</pinyin></item>
        <item><char>lǔ</char><pinyin>lu3</pinyin></item>
        <item><char>lù</char><pinyin>lu4</pinyin></item>
        
      	<item><char>luān</char><pinyin>luan1</pinyin></item>
        <item><char>luán</char><pinyin>luan2</pinyin></item>
        <item><char>luǎn</char><pinyin>luan3</pinyin></item>
        <item><char>luàn</char><pinyin>luan4</pinyin></item>
        
      	<item><char>lūn</char><pinyin>lun1</pinyin></item>
        <item><char>lún</char><pinyin>lun2</pinyin></item>
        <item><char>lǔn</char><pinyin>lun3</pinyin></item>
        <item><char>lùn</char><pinyin>lun4</pinyin></item>
        
      	<item><char>luō</char><pinyin>luo1</pinyin></item>
        <item><char>luó</char><pinyin>luo2</pinyin></item>
        <item><char>luǒ</char><pinyin>luo3</pinyin></item>
        <item><char>luò</char><pinyin>luo4</pinyin></item>
        
        <item><char>lüē</char><pinyin>lüe1</pinyin></item>
        <item><char>lüé</char><pinyin>lüe2</pinyin></item>
        <item><char>lüě</char><pinyin>lüe3</pinyin></item>
        <item><char>lüè</char><pinyin>lüe4</pinyin></item>
        
      	<item><char>lü</char><pinyin>lü1</pinyin></item>
        <item><char>lü</char><pinyin>lü2</pinyin></item>
        <item><char>lü</char><pinyin>lü3</pinyin></item>
        <item><char>lü</char><pinyin>lü4</pinyin></item>
      </group>
      <group key="m">
        
      	<item><char>māi</char><pinyin>mai1</pinyin></item>
        <item><char>mái</char><pinyin>mai2</pinyin></item>
        <item><char>mǎi</char><pinyin>mai3</pinyin></item>
        <item><char>mài</char><pinyin>mai4</pinyin></item>
        
        <item><char>māng</char><pinyin>mang1</pinyin></item>
        <item><char>máng</char><pinyin>mang2</pinyin></item>
        <item><char>mǎng</char><pinyin>mang3</pinyin></item>
        <item><char>màng</char><pinyin>mang4</pinyin></item>
        
        <item><char>mān</char><pinyin>man1</pinyin></item>
        <item><char>mán</char><pinyin>man2</pinyin></item>
        <item><char>mǎn</char><pinyin>man3</pinyin></item>
        <item><char>màn</char><pinyin>man4</pinyin></item>
        
      	<item><char>māo</char><pinyin>mao1</pinyin></item>
        <item><char>máo</char><pinyin>mao2</pinyin></item>
        <item><char>mǎo</char><pinyin>mao3</pinyin></item>
        <item><char>mào</char><pinyin>mao4</pinyin></item>
        
        <item><char>mā</char><pinyin>ma1</pinyin></item>
        <item><char>má</char><pinyin>ma2</pinyin></item>
        <item><char>mǎ</char><pinyin>ma3</pinyin></item>
        <item><char>mà</char><pinyin>ma4</pinyin></item>
        
      	<item><char>mēi</char><pinyin>mei1</pinyin></item>
        <item><char>méi</char><pinyin>mei2</pinyin></item>
        <item><char>měi</char><pinyin>mei3</pinyin></item>
        <item><char>mèi</char><pinyin>mei4</pinyin></item>
        
        <item><char>mēng</char><pinyin>meng1</pinyin></item>
        <item><char>méng</char><pinyin>meng2</pinyin></item>
        <item><char>měng</char><pinyin>meng3</pinyin></item>
        <item><char>mèng</char><pinyin>meng4</pinyin></item>
        
        <item><char>mēn</char><pinyin>men1</pinyin></item>
        <item><char>mén</char><pinyin>men2</pinyin></item>
        <item><char>měn</char><pinyin>men3</pinyin></item>
        <item><char>mèn</char><pinyin>men4</pinyin></item>
        
        <item><char>mē</char><pinyin>me1</pinyin></item>
        <item><char>mé</char><pinyin>me2</pinyin></item>
        <item><char>mě</char><pinyin>me3</pinyin></item>
        <item><char>mè</char><pinyin>me4</pinyin></item>
        
        <item><char>mī</char><pinyin>mi1</pinyin></item>
        <item><char>mí</char><pinyin>mi2</pinyin></item>
        <item><char>mǐ</char><pinyin>mi3</pinyin></item>
        <item><char>mì</char><pinyin>mi4</pinyin></item>
        
      	<item><char>miān</char><pinyin>mian1</pinyin></item>
        <item><char>mián</char><pinyin>mian2</pinyin></item>
        <item><char>miǎn</char><pinyin>mian3</pinyin></item>
        <item><char>miàn</char><pinyin>mian4</pinyin></item>
        
      	<item><char>miāo</char><pinyin>miao1</pinyin></item>
        <item><char>miáo</char><pinyin>miao2</pinyin></item>
        <item><char>miǎo</char><pinyin>miao3</pinyin></item>
        <item><char>miào</char><pinyin>miao4</pinyin></item>
        
      	<item><char>miē</char><pinyin>mie1</pinyin></item>
        <item><char>mié</char><pinyin>mie2</pinyin></item>
        <item><char>miě</char><pinyin>mie3</pinyin></item>
        <item><char>miè</char><pinyin>mie4</pinyin></item>
        
        <item><char>mīng</char><pinyin>ming1</pinyin></item>
        <item><char>míng</char><pinyin>ming2</pinyin></item>
        <item><char>mǐng</char><pinyin>ming3</pinyin></item>
        <item><char>mìng</char><pinyin>ming4</pinyin></item>
        
        <item><char>mīn</char><pinyin>min1</pinyin></item>
        <item><char>mín</char><pinyin>min2</pinyin></item>
        <item><char>mǐn</char><pinyin>min3</pinyin></item>
        <item><char>mìn</char><pinyin>min4</pinyin></item>
        
      	<item><char>mīu</char><pinyin>miu1</pinyin></item>
        <item><char>míu</char><pinyin>miu2</pinyin></item>
        <item><char>mǐu</char><pinyin>miu3</pinyin></item>
        <item><char>mìu</char><pinyin>miu4</pinyin></item>
        
      	<item><char>mōu</char><pinyin>mou1</pinyin></item>
        <item><char>móu</char><pinyin>mou2</pinyin></item>
        <item><char>mǒu</char><pinyin>mou3</pinyin></item>
        <item><char>mòu</char><pinyin>mou4</pinyin></item>
        
        <item><char>mō</char><pinyin>mo1</pinyin></item>
        <item><char>mó</char><pinyin>mo2</pinyin></item>
        <item><char>mǒ</char><pinyin>mo3</pinyin></item>
        <item><char>mò</char><pinyin>mo4</pinyin></item>
        
        <item><char>mū</char><pinyin>mu1</pinyin></item>
        <item><char>mú</char><pinyin>mu2</pinyin></item>
        <item><char>mǔ</char><pinyin>mu3</pinyin></item>
        <item><char>mù</char><pinyin>mu4</pinyin></item>
      </group>
      <group key="n">
        
      	<item><char>nāi</char><pinyin>nai1</pinyin></item>
        <item><char>nái</char><pinyin>nai2</pinyin></item>
        <item><char>nǎi</char><pinyin>nai3</pinyin></item>
        <item><char>nài</char><pinyin>nai4</pinyin></item>
        
        <item><char>nāng</char><pinyin>nang1</pinyin></item>
        <item><char>náng</char><pinyin>nang2</pinyin></item>
        <item><char>nǎng</char><pinyin>nang3</pinyin></item>
        <item><char>nàng</char><pinyin>nang4</pinyin></item>
        
        <item><char>nān</char><pinyin>nan1</pinyin></item>
        <item><char>nán</char><pinyin>nan2</pinyin></item>
        <item><char>nǎn</char><pinyin>nan3</pinyin></item>
        <item><char>nàn</char><pinyin>nan4</pinyin></item>
        
      	<item><char>nāo</char><pinyin>nao1</pinyin></item>
        <item><char>náo</char><pinyin>nao2</pinyin></item>
        <item><char>nǎo</char><pinyin>nao3</pinyin></item>
        <item><char>nào</char><pinyin>nao4</pinyin></item>
        
        <item><char>nā</char><pinyin>na1</pinyin></item>
        <item><char>ná</char><pinyin>na2</pinyin></item>
        <item><char>nǎ</char><pinyin>na3</pinyin></item>
        <item><char>nà</char><pinyin>na4</pinyin></item>
        
      	<item><char>nēi</char><pinyin>nei1</pinyin></item>
        <item><char>néi</char><pinyin>nei2</pinyin></item>
        <item><char>něi</char><pinyin>nei3</pinyin></item>
        <item><char>nèi</char><pinyin>nei4</pinyin></item>
        
        <item><char>nēng</char><pinyin>neng1</pinyin></item>
        <item><char>néng</char><pinyin>neng2</pinyin></item>
        <item><char>něng</char><pinyin>neng3</pinyin></item>
        <item><char>nèng</char><pinyin>neng4</pinyin></item>
        
        <item><char>nēn</char><pinyin>nen1</pinyin></item>
        <item><char>nén</char><pinyin>nen2</pinyin></item>
        <item><char>něn</char><pinyin>nen3</pinyin></item>
        <item><char>nèn</char><pinyin>nen4</pinyin></item>
        
        <item><char>nē</char><pinyin>ne1</pinyin></item>
        <item><char>né</char><pinyin>ne2</pinyin></item>
        <item><char>ně</char><pinyin>ne3</pinyin></item>
        <item><char>nè</char><pinyin>ne4</pinyin></item>
        
        <item><char>niāng</char><pinyin>niang1</pinyin></item>
        <item><char>niáng</char><pinyin>niang2</pinyin></item>
        <item><char>niǎng</char><pinyin>niang3</pinyin></item>
        <item><char>niàng</char><pinyin>niang4</pinyin></item>
        
        <item><char>niān</char><pinyin>nian1</pinyin></item>
        <item><char>nián</char><pinyin>nian2</pinyin></item>
        <item><char>niǎn</char><pinyin>nian3</pinyin></item>
        <item><char>niàn</char><pinyin>nian4</pinyin></item>
        
      	<item><char>niāo</char><pinyin>niao1</pinyin></item>
        <item><char>niáo</char><pinyin>niao2</pinyin></item>
        <item><char>niǎo</char><pinyin>niao3</pinyin></item>
        <item><char>niào</char><pinyin>niao4</pinyin></item>
        
      	<item><char>niē</char><pinyin>nie1</pinyin></item>
        <item><char>nié</char><pinyin>nie2</pinyin></item>
        <item><char>niě</char><pinyin>nie3</pinyin></item>
        <item><char>niè</char><pinyin>nie4</pinyin></item>
        
        <item><char>nīng</char><pinyin>ning1</pinyin></item>
        <item><char>níng</char><pinyin>ning2</pinyin></item>
        <item><char>nǐng</char><pinyin>ning3</pinyin></item>
        <item><char>nìng</char><pinyin>ning4</pinyin></item>
        
        <item><char>nīn</char><pinyin>nin1</pinyin></item>
        <item><char>nín</char><pinyin>nin2</pinyin></item>
        <item><char>nǐn</char><pinyin>nin3</pinyin></item>
        <item><char>nìn</char><pinyin>nin4</pinyin></item>
        
      	<item><char>nīu</char><pinyin>niu1</pinyin></item>
        <item><char>níu</char><pinyin>niu2</pinyin></item>
        <item><char>nǐu</char><pinyin>niu3</pinyin></item>
        <item><char>nìu</char><pinyin>niu4</pinyin></item>
        
        <item><char>nī</char><pinyin>ni1</pinyin></item>
        <item><char>ní</char><pinyin>ni2</pinyin></item>
        <item><char>nǐ</char><pinyin>ni3</pinyin></item>
        <item><char>nì</char><pinyin>ni4</pinyin></item>
        
        <item><char>nōng</char><pinyin>nong1</pinyin></item>
        <item><char>nóng</char><pinyin>nong2</pinyin></item>
        <item><char>nǒng</char><pinyin>nong3</pinyin></item>
        <item><char>nòng</char><pinyin>nong4</pinyin></item>
        
      	<item><char>nōu</char><pinyin>nou1</pinyin></item>
        <item><char>nóu</char><pinyin>nou2</pinyin></item>
        <item><char>nǒu</char><pinyin>nou3</pinyin></item>
        <item><char>nòu</char><pinyin>nou4</pinyin></item>
        
      	<item><char>nū</char><pinyin>nu1</pinyin></item>
        <item><char>nú</char><pinyin>nu2</pinyin></item>
        <item><char>nǔ</char><pinyin>nu3</pinyin></item>
        <item><char>nù</char><pinyin>nu4</pinyin></item>
        
      	<item><char>nuān</char><pinyin>nuan1</pinyin></item>
        <item><char>nuán</char><pinyin>nuan2</pinyin></item>
        <item><char>nuǎn</char><pinyin>nuan3</pinyin></item>
        <item><char>nuàn</char><pinyin>nuan4</pinyin></item>
        
      	<item><char>nuō</char><pinyin>nuo1</pinyin></item>
        <item><char>nuó</char><pinyin>nuo2</pinyin></item>
        <item><char>nuǒ</char><pinyin>nuo3</pinyin></item>
        <item><char>nuò</char><pinyin>nuo4</pinyin></item>
        
      	<item><char>nüē</char><pinyin>nüe1</pinyin></item>
        <item><char>nüé</char><pinyin>nüe2</pinyin></item>
        <item><char>nüě</char><pinyin>nüe3</pinyin></item>
        <item><char>nüè</char><pinyin>nüe4</pinyin></item>

        <item><char>nü</char><pinyin>nü1</pinyin></item>
        <item><char>nü</char><pinyin>nü2</pinyin></item>
        <item><char>nü</char><pinyin>nü3</pinyin></item>
        <item><char>nü</char><pinyin>nü4</pinyin></item>
        
      </group>
      <group key="o">
        
      	<item><char>ōu</char><pinyin>ou1</pinyin></item>
        <item><char>óu</char><pinyin>ou2</pinyin></item>
        <item><char>ǒu</char><pinyin>ou3</pinyin></item>
        <item><char>òu</char><pinyin>ou4</pinyin></item>

        <item><char>ō</char><pinyin>o1</pinyin></item>
        <item><char>ó</char><pinyin>o2</pinyin></item>
        <item><char>ǒ</char><pinyin>o3</pinyin></item>
        <item><char>ò</char><pinyin>o4</pinyin></item>
        
      </group>
      <group key="p">
        
      	<item><char>pāi</char><pinyin>pai1</pinyin></item>
        <item><char>pái</char><pinyin>pai2</pinyin></item>
        <item><char>pǎi</char><pinyin>pai3</pinyin></item>
        <item><char>pài</char><pinyin>pai4</pinyin></item>
        
        <item><char>pāng</char><pinyin>pang1</pinyin></item>
        <item><char>páng</char><pinyin>pang2</pinyin></item>
        <item><char>pǎng</char><pinyin>pang3</pinyin></item>
        <item><char>pàng</char><pinyin>pang4</pinyin></item>
        
        <item><char>pān</char><pinyin>pan1</pinyin></item>
        <item><char>pán</char><pinyin>pan2</pinyin></item>
        <item><char>pǎn</char><pinyin>pan3</pinyin></item>
        <item><char>pàn</char><pinyin>pan4</pinyin></item>
        
      	<item><char>pāo</char><pinyin>pao1</pinyin></item>
        <item><char>páo</char><pinyin>pao2</pinyin></item>
        <item><char>pǎo</char><pinyin>pao3</pinyin></item>
        <item><char>pào</char><pinyin>pao4</pinyin></item>
        
        <item><char>pā</char><pinyin>pa1</pinyin></item>
        <item><char>pá</char><pinyin>pa2</pinyin></item>
        <item><char>pǎ</char><pinyin>pa3</pinyin></item>
        <item><char>pà</char><pinyin>pa4</pinyin></item>
        
        <item><char>pēi</char><pinyin>pei1</pinyin></item>
        <item><char>péi</char><pinyin>pei2</pinyin></item>
        <item><char>pěi</char><pinyin>pei3</pinyin></item>
        <item><char>pèi</char><pinyin>pei4</pinyin></item>
        
        <item><char>pēng</char><pinyin>peng1</pinyin></item>
        <item><char>péng</char><pinyin>peng2</pinyin></item>
        <item><char>pěng</char><pinyin>peng3</pinyin></item>
        <item><char>pèng</char><pinyin>peng4</pinyin></item>
        
        <item><char>pēn</char><pinyin>pen1</pinyin></item>
        <item><char>pén</char><pinyin>pen2</pinyin></item>
        <item><char>pěn</char><pinyin>pen3</pinyin></item>
        <item><char>pèn</char><pinyin>pen4</pinyin></item>
        
      	<item><char>piān</char><pinyin>pian1</pinyin></item>
        <item><char>pián</char><pinyin>pian2</pinyin></item>
        <item><char>piǎn</char><pinyin>pian3</pinyin></item>
        <item><char>piàn</char><pinyin>pian4</pinyin></item>
        
      	<item><char>piāo</char><pinyin>piao1</pinyin></item>
        <item><char>piáo</char><pinyin>piao2</pinyin></item>
        <item><char>piǎo</char><pinyin>piao3</pinyin></item>
        <item><char>piào</char><pinyin>piao4</pinyin></item>
        
      	<item><char>piē</char><pinyin>pie1</pinyin></item>
        <item><char>pié</char><pinyin>pie2</pinyin></item>
        <item><char>piě</char><pinyin>pie3</pinyin></item>
        <item><char>piè</char><pinyin>pie4</pinyin></item>
        
      	<item><char>pīng</char><pinyin>ping1</pinyin></item>
        <item><char>píng</char><pinyin>ping2</pinyin></item>
        <item><char>pǐng</char><pinyin>ping3</pinyin></item>
        <item><char>pìng</char><pinyin>ping4</pinyin></item>
        
        <item><char>pīn</char><pinyin>pin1</pinyin></item>
        <item><char>pín</char><pinyin>pin2</pinyin></item>
        <item><char>pǐn</char><pinyin>pin3</pinyin></item>
        <item><char>pìn</char><pinyin>pin4</pinyin></item>
        
        <item><char>pī</char><pinyin>pi1</pinyin></item>
        <item><char>pí</char><pinyin>pi2</pinyin></item>
        <item><char>pǐ</char><pinyin>pi3</pinyin></item>
        <item><char>pì</char><pinyin>pi4</pinyin></item>
        
      	<item><char>pōu</char><pinyin>pou1</pinyin></item>
        <item><char>póu</char><pinyin>pou2</pinyin></item>
        <item><char>pǒu</char><pinyin>pou3</pinyin></item>
        <item><char>pòu</char><pinyin>pou4</pinyin></item>
        
        <item><char>pō</char><pinyin>po1</pinyin></item>
        <item><char>pó</char><pinyin>po2</pinyin></item>
        <item><char>pǒ</char><pinyin>po3</pinyin></item>
        <item><char>pò</char><pinyin>po4</pinyin></item>
        
        <item><char>pū</char><pinyin>pu1</pinyin></item>
        <item><char>pú</char><pinyin>pu2</pinyin></item>
        <item><char>pǔ</char><pinyin>pu3</pinyin></item>
        <item><char>pù</char><pinyin>pu4</pinyin></item>
      </group>
      <group key="q">
        
        <item><char>qiāng</char><pinyin>qiang1</pinyin></item>
        <item><char>qiáng</char><pinyin>qiang2</pinyin></item>
        <item><char>qiǎng</char><pinyin>qiang3</pinyin></item>
        <item><char>qiàng</char><pinyin>qiang4</pinyin></item>
        
      	<item><char>qiān</char><pinyin>qian1</pinyin></item>
        <item><char>qián</char><pinyin>qian2</pinyin></item>
        <item><char>qiǎn</char><pinyin>qian3</pinyin></item>
        <item><char>qiàn</char><pinyin>qian4</pinyin></item>
        
        <item><char>qiāo</char><pinyin>qiao1</pinyin></item>
        <item><char>qiáo</char><pinyin>qiao2</pinyin></item>
        <item><char>qiǎo</char><pinyin>qiao3</pinyin></item>
        <item><char>qiào</char><pinyin>qiao4</pinyin></item>
        
        <item><char>qiā</char><pinyin>qia1</pinyin></item>
        <item><char>qiá</char><pinyin>qia2</pinyin></item>
        <item><char>qiǎ</char><pinyin>qia3</pinyin></item>
        <item><char>qià</char><pinyin>qia4</pinyin></item>
        
        <item><char>qiē</char><pinyin>qie1</pinyin></item>
        <item><char>qié</char><pinyin>qie2</pinyin></item>
        <item><char>qiě</char><pinyin>qie3</pinyin></item>
        <item><char>qiè</char><pinyin>qie4</pinyin></item>
        
      	<item><char>qīng</char><pinyin>qing1</pinyin></item>
        <item><char>qíng</char><pinyin>qing2</pinyin></item>
        <item><char>qǐng</char><pinyin>qing3</pinyin></item>
        <item><char>qìng</char><pinyin>qing4</pinyin></item>
        
        <item><char>qīn</char><pinyin>qin1</pinyin></item>
        <item><char>qín</char><pinyin>qin2</pinyin></item>
        <item><char>qǐn</char><pinyin>qin3</pinyin></item>
        <item><char>qìn</char><pinyin>qin4</pinyin></item>
        
        <item><char>qīong</char><pinyin>qiong1</pinyin></item>
        <item><char>qíong</char><pinyin>qiong2</pinyin></item>
        <item><char>qǐong</char><pinyin>qiong3</pinyin></item>
        <item><char>qìong</char><pinyin>qiong4</pinyin></item>
        
      	<item><char>qīu</char><pinyin>qiu1</pinyin></item>
        <item><char>qíu</char><pinyin>qiu2</pinyin></item>
        <item><char>qǐu</char><pinyin>qiu3</pinyin></item>
        <item><char>qìu</char><pinyin>qiu4</pinyin></item>
        
        <item><char>qī</char><pinyin>qi1</pinyin></item>
        <item><char>qí</char><pinyin>qi2</pinyin></item>
        <item><char>qǐ</char><pinyin>qi3</pinyin></item>
        <item><char>qì</char><pinyin>qi4</pinyin></item>
        
      	<item><char>quān</char><pinyin>quan1</pinyin></item>
        <item><char>quán</char><pinyin>quan2</pinyin></item>
        <item><char>quǎn</char><pinyin>quan3</pinyin></item>
        <item><char>quàn</char><pinyin>quan4</pinyin></item>
        
      	<item><char>quē</char><pinyin>que1</pinyin></item>
        <item><char>qué</char><pinyin>que2</pinyin></item>
        <item><char>quě</char><pinyin>que3</pinyin></item>
        <item><char>què</char><pinyin>que4</pinyin></item>
        
      	<item><char>qūn</char><pinyin>qun1</pinyin></item>
        <item><char>qún</char><pinyin>qun2</pinyin></item>
        <item><char>qǔn</char><pinyin>qun3</pinyin></item>
        <item><char>qùn</char><pinyin>qun4</pinyin></item>

        <item><char>qū</char><pinyin>qu1</pinyin></item>
        <item><char>qú</char><pinyin>qu2</pinyin></item>
        <item><char>qǔ</char><pinyin>qu3</pinyin></item>
        <item><char>qù</char><pinyin>qu4</pinyin></item>
        
      </group>
      <group key="r">
        
        <item><char>rāng</char><pinyin>rang1</pinyin></item>
        <item><char>ráng</char><pinyin>rang2</pinyin></item>
        <item><char>rǎng</char><pinyin>rang3</pinyin></item>
        <item><char>ràng</char><pinyin>rang4</pinyin></item>
        
        <item><char>rān</char><pinyin>ran1</pinyin></item>
        <item><char>rán</char><pinyin>ran2</pinyin></item>
        <item><char>rǎn</char><pinyin>ran3</pinyin></item>
        <item><char>ràn</char><pinyin>ran4</pinyin></item>
        
      	<item><char>rāo</char><pinyin>rao1</pinyin></item>
        <item><char>ráo</char><pinyin>rao2</pinyin></item>
        <item><char>rǎo</char><pinyin>rao3</pinyin></item>
        <item><char>rào</char><pinyin>rao4</pinyin></item>
        
        <item><char>rēng</char><pinyin>reng1</pinyin></item>
        <item><char>réng</char><pinyin>reng2</pinyin></item>
        <item><char>rěng</char><pinyin>reng3</pinyin></item>
        <item><char>rèng</char><pinyin>reng4</pinyin></item>
        
        <item><char>rēn</char><pinyin>ren1</pinyin></item>
        <item><char>rén</char><pinyin>ren2</pinyin></item>
        <item><char>rěn</char><pinyin>ren3</pinyin></item>
        <item><char>rèn</char><pinyin>ren4</pinyin></item>
        
        <item><char>rē</char><pinyin>re1</pinyin></item>
        <item><char>ré</char><pinyin>re2</pinyin></item>
        <item><char>rě</char><pinyin>re3</pinyin></item>
        <item><char>rè</char><pinyin>re4</pinyin></item>
        
        <item><char>rī</char><pinyin>ri1</pinyin></item>
        <item><char>rí</char><pinyin>ri2</pinyin></item>
        <item><char>rǐ</char><pinyin>ri3</pinyin></item>
        <item><char>rì</char><pinyin>ri4</pinyin></item>
        
      	<item><char>rōng</char><pinyin>rong1</pinyin></item>
        <item><char>róng</char><pinyin>rong2</pinyin></item>
        <item><char>rǒng</char><pinyin>rong3</pinyin></item>
        <item><char>ròng</char><pinyin>rong4</pinyin></item>
        
      	<item><char>rōu</char><pinyin>rou1</pinyin></item>
        <item><char>róu</char><pinyin>rou2</pinyin></item>
        <item><char>rǒu</char><pinyin>rou3</pinyin></item>
        <item><char>ròu</char><pinyin>rou4</pinyin></item>
        
      	<item><char>ruān</char><pinyin>ruan1</pinyin></item>
        <item><char>ruán</char><pinyin>ruan2</pinyin></item>
        <item><char>ruǎn</char><pinyin>ruan3</pinyin></item>
        <item><char>ruàn</char><pinyin>ruan4</pinyin></item>
        
        <item><char>ruā</char><pinyin>rua1</pinyin></item>
        <item><char>ruá</char><pinyin>rua2</pinyin></item>
        <item><char>ruǎ</char><pinyin>rua3</pinyin></item>
        <item><char>ruà</char><pinyin>rua4</pinyin></item>
        
        <item><char>ruī</char><pinyin>rui1</pinyin></item>
        <item><char>ruí</char><pinyin>rui2</pinyin></item>
        <item><char>ruǐ</char><pinyin>rui3</pinyin></item>
        <item><char>ruì</char><pinyin>rui4</pinyin></item>
        
      	<item><char>rūn</char><pinyin>run1</pinyin></item>
        <item><char>rún</char><pinyin>run2</pinyin></item>
        <item><char>rǔn</char><pinyin>run3</pinyin></item>
        <item><char>rùn</char><pinyin>run4</pinyin></item>
        
      	<item><char>ruō</char><pinyin>ruo1</pinyin></item>
        <item><char>ruó</char><pinyin>ruo2</pinyin></item>
        <item><char>ruǒ</char><pinyin>ruo3</pinyin></item>
        <item><char>ruò</char><pinyin>ruo4</pinyin></item>

        <item><char>rū</char><pinyin>ru1</pinyin></item>
        <item><char>rú</char><pinyin>ru2</pinyin></item>
        <item><char>rǔ</char><pinyin>ru3</pinyin></item>
        <item><char>rù</char><pinyin>ru4</pinyin></item>
        
      </group>
      <group key="s">
        
      	<item><char>sāi</char><pinyin>sai1</pinyin></item>
        <item><char>sái</char><pinyin>sai2</pinyin></item>
        <item><char>sǎi</char><pinyin>sai3</pinyin></item>
        <item><char>sài</char><pinyin>sai4</pinyin></item>
        
      	<item><char>sāng</char><pinyin>sang1</pinyin></item>
        <item><char>sáng</char><pinyin>sang2</pinyin></item>
        <item><char>sǎng</char><pinyin>sang3</pinyin></item>
        <item><char>sàng</char><pinyin>sang4</pinyin></item>
        
        <item><char>sān</char><pinyin>san1</pinyin></item>
        <item><char>sán</char><pinyin>san2</pinyin></item>
        <item><char>sǎn</char><pinyin>san3</pinyin></item>
        <item><char>sàn</char><pinyin>san4</pinyin></item>
        
        <item><char>sāo</char><pinyin>sao1</pinyin></item>
        <item><char>sáo</char><pinyin>sao2</pinyin></item>
        <item><char>sǎo</char><pinyin>sao3</pinyin></item>
        <item><char>sào</char><pinyin>sao4</pinyin></item>
        
        <item><char>sā</char><pinyin>sa1</pinyin></item>
        <item><char>sá</char><pinyin>sa2</pinyin></item>
        <item><char>sǎ</char><pinyin>sa3</pinyin></item>
        <item><char>sà</char><pinyin>sa4</pinyin></item>
        
        <item><char>sēng</char><pinyin>seng1</pinyin></item>
        <item><char>séng</char><pinyin>seng2</pinyin></item>
        <item><char>sěng</char><pinyin>seng3</pinyin></item>
        <item><char>sèng</char><pinyin>seng4</pinyin></item>
        
        <item><char>sēn</char><pinyin>sen1</pinyin></item>
        <item><char>sén</char><pinyin>sen2</pinyin></item>
        <item><char>sěn</char><pinyin>sen3</pinyin></item>
        <item><char>sèn</char><pinyin>sen4</pinyin></item>
        
        <item><char>sē</char><pinyin>se1</pinyin></item>
        <item><char>sé</char><pinyin>se2</pinyin></item>
        <item><char>sě</char><pinyin>se3</pinyin></item>
        <item><char>sè</char><pinyin>se4</pinyin></item>
        
      	<item><char>shāi</char><pinyin>shai1</pinyin></item>
        <item><char>shái</char><pinyin>shai2</pinyin></item>
        <item><char>shǎi</char><pinyin>shai3</pinyin></item>
        <item><char>shài</char><pinyin>shai4</pinyin></item>
        
      	<item><char>shān</char><pinyin>shan1</pinyin></item>
        <item><char>shán</char><pinyin>shan2</pinyin></item>
        <item><char>shǎn</char><pinyin>shan3</pinyin></item>
        <item><char>shàn</char><pinyin>shan4</pinyin></item>
        
      	<item><char>shāng</char><pinyin>shang1</pinyin></item>
        <item><char>sháng</char><pinyin>shang2</pinyin></item>
        <item><char>shǎng</char><pinyin>shang3</pinyin></item>
        <item><char>shàng</char><pinyin>shang4</pinyin></item>
        
      	<item><char>shāo</char><pinyin>shao1</pinyin></item>
        <item><char>sháo</char><pinyin>shao2</pinyin></item>
        <item><char>shǎo</char><pinyin>shao3</pinyin></item>
        <item><char>shào</char><pinyin>shao4</pinyin></item>
        
        <item><char>shā</char><pinyin>sha1</pinyin></item>
        <item><char>shá</char><pinyin>sha2</pinyin></item>
        <item><char>shǎ</char><pinyin>sha3</pinyin></item>
        <item><char>shà</char><pinyin>sha4</pinyin></item>
        
      	<item><char>shēi</char><pinyin>shei1</pinyin></item>
        <item><char>shéi</char><pinyin>shei2</pinyin></item>
        <item><char>shěi</char><pinyin>shei3</pinyin></item>
        <item><char>shèi</char><pinyin>shei4</pinyin></item>
        
      	<item><char>shēn</char><pinyin>shen1</pinyin></item>
        <item><char>shén</char><pinyin>shen2</pinyin></item>
        <item><char>shěn</char><pinyin>shen3</pinyin></item>
        <item><char>shèn</char><pinyin>shen4</pinyin></item>
        
      	<item><char>shēng</char><pinyin>sheng1</pinyin></item>
        <item><char>shéng</char><pinyin>sheng2</pinyin></item>
        <item><char>shěng</char><pinyin>sheng3</pinyin></item>
        <item><char>shèng</char><pinyin>sheng4</pinyin></item>
        
        <item><char>shē</char><pinyin>she1</pinyin></item>
        <item><char>shé</char><pinyin>she2</pinyin></item>
        <item><char>shě</char><pinyin>she3</pinyin></item>
        <item><char>shè</char><pinyin>she4</pinyin></item>
        
        <item><char>shī</char><pinyin>shi1</pinyin></item>
        <item><char>shí</char><pinyin>shi2</pinyin></item>
        <item><char>shǐ</char><pinyin>shi3</pinyin></item>
        <item><char>shì</char><pinyin>shi4</pinyin></item>
        
      	<item><char>shōu</char><pinyin>shou1</pinyin></item>
        <item><char>shóu</char><pinyin>shou2</pinyin></item>
        <item><char>shǒu</char><pinyin>shou3</pinyin></item>
        <item><char>shòu</char><pinyin>shou4</pinyin></item>
        
      	<item><char>shuāi</char><pinyin>shuai1</pinyin></item>
        <item><char>shuái</char><pinyin>shuai2</pinyin></item>
        <item><char>shuǎi</char><pinyin>shuai3</pinyin></item>
        <item><char>shuài</char><pinyin>shuai4</pinyin></item>
        
        <item><char>shuā</char><pinyin>shua1</pinyin></item>
        <item><char>shuá</char><pinyin>shua2</pinyin></item>
        <item><char>shuǎ</char><pinyin>shua3</pinyin></item>
        <item><char>shuà</char><pinyin>shua4</pinyin></item>
        
        <item><char>shuāng</char><pinyin>shuang1</pinyin></item>
        <item><char>shuáng</char><pinyin>shuang2</pinyin></item>
        <item><char>shuǎng</char><pinyin>shuang3</pinyin></item>
        <item><char>shuàng</char><pinyin>shuang4</pinyin></item>
        
        <item><char>shuān</char><pinyin>shuan1</pinyin></item>
        <item><char>shuán</char><pinyin>shuan2</pinyin></item>
        <item><char>shuǎn</char><pinyin>shuan3</pinyin></item>
        <item><char>shuàn</char><pinyin>shuan4</pinyin></item>
        
        <item><char>shuī</char><pinyin>shui1</pinyin></item>
        <item><char>shuí</char><pinyin>shui2</pinyin></item>
        <item><char>shuǐ</char><pinyin>shui3</pinyin></item>
        <item><char>shuì</char><pinyin>shui4</pinyin></item>
        
      	<item><char>shūn</char><pinyin>shun1</pinyin></item>
        <item><char>shún</char><pinyin>shun2</pinyin></item>
        <item><char>shǔn</char><pinyin>shun3</pinyin></item>
        <item><char>shùn</char><pinyin>shun4</pinyin></item>
        
      	<item><char>shuō</char><pinyin>shuo1</pinyin></item>
        <item><char>shuó</char><pinyin>shuo2</pinyin></item>
        <item><char>shuǒ</char><pinyin>shuo3</pinyin></item>
        <item><char>shuò</char><pinyin>shuo4</pinyin></item>
        
        <item><char>shū</char><pinyin>shu1</pinyin></item>
        <item><char>shú</char><pinyin>shu2</pinyin></item>
        <item><char>shǔ</char><pinyin>shu3</pinyin></item>
        <item><char>shù</char><pinyin>shu4</pinyin></item>
        
        <item><char>sī</char><pinyin>si1</pinyin></item>
        <item><char>sí</char><pinyin>si2</pinyin></item>
        <item><char>sǐ</char><pinyin>si3</pinyin></item>
        <item><char>sì</char><pinyin>si4</pinyin></item>
        
      	<item><char>sōng</char><pinyin>song1</pinyin></item>
        <item><char>sóng</char><pinyin>song2</pinyin></item>
        <item><char>sǒng</char><pinyin>song3</pinyin></item>
        <item><char>sòng</char><pinyin>song4</pinyin></item>
        
      	<item><char>sōu</char><pinyin>sou1</pinyin></item>
        <item><char>sóu</char><pinyin>sou2</pinyin></item>
        <item><char>sǒu</char><pinyin>sou3</pinyin></item>
        <item><char>sòu</char><pinyin>sou4</pinyin></item>
        
      	<item><char>suān</char><pinyin>suan1</pinyin></item>
        <item><char>suán</char><pinyin>suan2</pinyin></item>
        <item><char>suǎn</char><pinyin>suan3</pinyin></item>
        <item><char>suàn</char><pinyin>suan4</pinyin></item>
        
      	<item><char>suī</char><pinyin>sui1</pinyin></item>
        <item><char>suí</char><pinyin>sui2</pinyin></item>
        <item><char>suǐ</char><pinyin>sui3</pinyin></item>
        <item><char>suì</char><pinyin>sui4</pinyin></item>
        
      	<item><char>sūn</char><pinyin>sun1</pinyin></item>
        <item><char>sún</char><pinyin>sun2</pinyin></item>
        <item><char>sǔn</char><pinyin>sun3</pinyin></item>
        <item><char>sùn</char><pinyin>sun4</pinyin></item>
        
      	<item><char>suō</char><pinyin>suo1</pinyin></item>
        <item><char>suó</char><pinyin>suo2</pinyin></item>
        <item><char>suǒ</char><pinyin>suo3</pinyin></item>
        <item><char>suò</char><pinyin>suo4</pinyin></item>

        <item><char>sū</char><pinyin>su1</pinyin></item>
        <item><char>sú</char><pinyin>su2</pinyin></item>
        <item><char>sǔ</char><pinyin>su3</pinyin></item>
        <item><char>sù</char><pinyin>su4</pinyin></item>
        
      </group>
      <group key="t">
        
      	<item><char>tāi</char><pinyin>tai1</pinyin></item>
        <item><char>tái</char><pinyin>tai2</pinyin></item>
        <item><char>tǎi</char><pinyin>tai3</pinyin></item>
        <item><char>tài</char><pinyin>tai4</pinyin></item>
        
      	<item><char>tāng</char><pinyin>tang1</pinyin></item>
        <item><char>táng</char><pinyin>tang2</pinyin></item>
        <item><char>tǎng</char><pinyin>tang3</pinyin></item>
        <item><char>tàng</char><pinyin>tang4</pinyin></item>
        
        <item><char>tān</char><pinyin>tan1</pinyin></item>
        <item><char>tán</char><pinyin>tan2</pinyin></item>
        <item><char>tǎn</char><pinyin>tan3</pinyin></item>
        <item><char>tàn</char><pinyin>tan4</pinyin></item>
        
        <item><char>tāo</char><pinyin>tao1</pinyin></item>
        <item><char>táo</char><pinyin>tao2</pinyin></item>
        <item><char>tǎo</char><pinyin>tao3</pinyin></item>
        <item><char>tào</char><pinyin>tao4</pinyin></item>
        
        <item><char>tā</char><pinyin>ta1</pinyin></item>
        <item><char>tá</char><pinyin>ta2</pinyin></item>
        <item><char>tǎ</char><pinyin>ta3</pinyin></item>
        <item><char>tà</char><pinyin>ta4</pinyin></item>
        
      	<item><char>tēng</char><pinyin>teng1</pinyin></item>
        <item><char>téng</char><pinyin>teng2</pinyin></item>
        <item><char>těng</char><pinyin>teng3</pinyin></item>
        <item><char>tèng</char><pinyin>teng4</pinyin></item>
        
        <item><char>tē</char><pinyin>te1</pinyin></item>
        <item><char>té</char><pinyin>te2</pinyin></item>
        <item><char>tě</char><pinyin>te3</pinyin></item>
        <item><char>tè</char><pinyin>te4</pinyin></item>
        
      	<item><char>tiān</char><pinyin>tian1</pinyin></item>
        <item><char>tián</char><pinyin>tian2</pinyin></item>
        <item><char>tiǎn</char><pinyin>tian3</pinyin></item>
        <item><char>tiàn</char><pinyin>tian4</pinyin></item>
        
      	<item><char>tiāo</char><pinyin>tiao1</pinyin></item>
        <item><char>tiáo</char><pinyin>tiao2</pinyin></item>
        <item><char>tiǎo</char><pinyin>tiao3</pinyin></item>
        <item><char>tiào</char><pinyin>tiao4</pinyin></item>
        
      	<item><char>tiē</char><pinyin>tie1</pinyin></item>
        <item><char>tié</char><pinyin>tie2</pinyin></item>
        <item><char>tiě</char><pinyin>tie3</pinyin></item>
        <item><char>tiè</char><pinyin>tie4</pinyin></item>
        
      	<item><char>tīng</char><pinyin>ting1</pinyin></item>
        <item><char>tíng</char><pinyin>ting2</pinyin></item>
        <item><char>tǐng</char><pinyin>ting3</pinyin></item>
        <item><char>tìng</char><pinyin>ting4</pinyin></item>
        
        <item><char>tī</char><pinyin>ti1</pinyin></item>
        <item><char>tí</char><pinyin>ti2</pinyin></item>
        <item><char>tǐ</char><pinyin>ti3</pinyin></item>
        <item><char>tì</char><pinyin>ti4</pinyin></item>
        
        <item><char>tōng</char><pinyin>tong1</pinyin></item>
        <item><char>tóng</char><pinyin>tong2</pinyin></item>
        <item><char>tǒng</char><pinyin>tong3</pinyin></item>
        <item><char>tòng</char><pinyin>tong4</pinyin></item>
        
      	<item><char>tōu</char><pinyin>tou1</pinyin></item>
        <item><char>tóu</char><pinyin>tou2</pinyin></item>
        <item><char>tǒu</char><pinyin>tou3</pinyin></item>
        <item><char>tòu</char><pinyin>tou4</pinyin></item>
        
      	<item><char>tuān</char><pinyin>tuan1</pinyin></item>
        <item><char>tuán</char><pinyin>tuan2</pinyin></item>
        <item><char>tuǎn</char><pinyin>tuan3</pinyin></item>
        <item><char>tuàn</char><pinyin>tuan4</pinyin></item>
        
      	<item><char>tuī</char><pinyin>tui1</pinyin></item>
        <item><char>tuí</char><pinyin>tui2</pinyin></item>
        <item><char>tuǐ</char><pinyin>tui3</pinyin></item>
        <item><char>tuì</char><pinyin>tui4</pinyin></item>
        
      	<item><char>tūn</char><pinyin>tun1</pinyin></item>
        <item><char>tún</char><pinyin>tun2</pinyin></item>
        <item><char>tǔn</char><pinyin>tun3</pinyin></item>
        <item><char>tùn</char><pinyin>tun4</pinyin></item>
        
      	<item><char>tuō</char><pinyin>tuo1</pinyin></item>
        <item><char>tuó</char><pinyin>tuo2</pinyin></item>
        <item><char>tuǒ</char><pinyin>tuo3</pinyin></item>
        <item><char>tuò</char><pinyin>tuo4</pinyin></item>

        <item><char>tū</char><pinyin>tu1</pinyin></item>
        <item><char>tú</char><pinyin>tu2</pinyin></item>
        <item><char>tǔ</char><pinyin>tu3</pinyin></item>
        <item><char>tù</char><pinyin>tu4</pinyin></item>
        
      </group>
      <group key="w">
        
      	<item><char>wāi</char><pinyin>wai1</pinyin></item>
        <item><char>wái</char><pinyin>wai2</pinyin></item>
        <item><char>wǎi</char><pinyin>wai3</pinyin></item>
        <item><char>wài</char><pinyin>wai4</pinyin></item>
        
        <item><char>wāng</char><pinyin>wang1</pinyin></item>
        <item><char>wáng</char><pinyin>wang2</pinyin></item>
        <item><char>wǎng</char><pinyin>wang3</pinyin></item>
        <item><char>wàng</char><pinyin>wang4</pinyin></item>
        
        <item><char>wān</char><pinyin>wan1</pinyin></item>
        <item><char>wán</char><pinyin>wan2</pinyin></item>
        <item><char>wǎn</char><pinyin>wan3</pinyin></item>
        <item><char>wàn</char><pinyin>wan4</pinyin></item>
        
        <item><char>wā</char><pinyin>wa1</pinyin></item>
        <item><char>wá</char><pinyin>wa2</pinyin></item>
        <item><char>wǎ</char><pinyin>wa3</pinyin></item>
        <item><char>wà</char><pinyin>wa4</pinyin></item>
        
        <item><char>wēi</char><pinyin>wei1</pinyin></item>
        <item><char>wéi</char><pinyin>wei2</pinyin></item>
        <item><char>wěi</char><pinyin>wei3</pinyin></item>
        <item><char>wèi</char><pinyin>wei4</pinyin></item>
        
        <item><char>wēng</char><pinyin>weng1</pinyin></item>
        <item><char>wéng</char><pinyin>weng2</pinyin></item>
        <item><char>wěng</char><pinyin>weng3</pinyin></item>
        <item><char>wèng</char><pinyin>weng4</pinyin></item>
        
        <item><char>wēn</char><pinyin>wen1</pinyin></item>
        <item><char>wén</char><pinyin>wen2</pinyin></item>
        <item><char>wěn</char><pinyin>wen3</pinyin></item>
        <item><char>wèn</char><pinyin>wen4</pinyin></item>
        
      	<item><char>wō</char><pinyin>wo1</pinyin></item>
        <item><char>wó</char><pinyin>wo2</pinyin></item>
        <item><char>wǒ</char><pinyin>wo3</pinyin></item>
        <item><char>wò</char><pinyin>wo4</pinyin></item>
        
      	<item><char>wū</char><pinyin>wu1</pinyin></item>
        <item><char>wú</char><pinyin>wu2</pinyin></item>
        <item><char>wǔ</char><pinyin>wu3</pinyin></item>
        <item><char>wù</char><pinyin>wu4</pinyin></item>
      </group>
      <group key="x">
          
        <item><char>xiāng</char><pinyin>xiang1</pinyin></item>
        <item><char>xiáng</char><pinyin>xiang2</pinyin></item>
        <item><char>xiǎng</char><pinyin>xiang3</pinyin></item>
        <item><char>xiàng</char><pinyin>xiang4</pinyin></item>
        
        <item><char>xiān</char><pinyin>xian1</pinyin></item>
        <item><char>xián</char><pinyin>xian2</pinyin></item>
        <item><char>xiǎn</char><pinyin>xian3</pinyin></item>
        <item><char>xiàn</char><pinyin>xian4</pinyin></item>
        
        <item><char>xiā</char><pinyin>xia1</pinyin></item>
        <item><char>xiá</char><pinyin>xia2</pinyin></item>
        <item><char>xiǎ</char><pinyin>xia3</pinyin></item>
        <item><char>xià</char><pinyin>xia4</pinyin></item>
        
        <item><char>xiāo</char><pinyin>xiao1</pinyin></item>
        <item><char>xiáo</char><pinyin>xiao2</pinyin></item>
        <item><char>xiǎo</char><pinyin>xiao3</pinyin></item>
        <item><char>xiào</char><pinyin>xiao4</pinyin></item>
        
      	<item><char>xiē</char><pinyin>xie1</pinyin></item>
        <item><char>xié</char><pinyin>xie2</pinyin></item>
        <item><char>xiě</char><pinyin>xie3</pinyin></item>
        <item><char>xiè</char><pinyin>xie4</pinyin></item>
        
      	<item><char>xīng</char><pinyin>xing1</pinyin></item>
        <item><char>xíng</char><pinyin>xing2</pinyin></item>
        <item><char>xǐng</char><pinyin>xing3</pinyin></item>
        <item><char>xìng</char><pinyin>xing4</pinyin></item>
        
        <item><char>xīn</char><pinyin>xin1</pinyin></item>
        <item><char>xín</char><pinyin>xin2</pinyin></item>
        <item><char>xǐn</char><pinyin>xin3</pinyin></item>
        <item><char>xìn</char><pinyin>xin4</pinyin></item>
        
        <item><char>xīong</char><pinyin>xiong1</pinyin></item>
        <item><char>xíong</char><pinyin>xiong2</pinyin></item>
        <item><char>xǐong</char><pinyin>xiong3</pinyin></item>
        <item><char>xìong</char><pinyin>xiong4</pinyin></item>
        
      	<item><char>xīu</char><pinyin>xiu1</pinyin></item>
        <item><char>xíu</char><pinyin>xiu2</pinyin></item>
        <item><char>xǐu</char><pinyin>xiu3</pinyin></item>
        <item><char>xìu</char><pinyin>xiu4</pinyin></item>
      
        <item><char>xī</char><pinyin>xi1</pinyin></item>
        <item><char>xí</char><pinyin>xi2</pinyin></item>
        <item><char>xǐ</char><pinyin>xi3</pinyin></item>
        <item><char>xì</char><pinyin>xi4</pinyin></item>
        
      	<item><char>xuān</char><pinyin>xuan1</pinyin></item>
        <item><char>xuán</char><pinyin>xuan2</pinyin></item>
        <item><char>xuǎn</char><pinyin>xuan3</pinyin></item>
        <item><char>xuàn</char><pinyin>xuan4</pinyin></item>
        
      	<item><char>xuē</char><pinyin>xue1</pinyin></item>
        <item><char>xué</char><pinyin>xue2</pinyin></item>
        <item><char>xuě</char><pinyin>xue3</pinyin></item>
        <item><char>xuè</char><pinyin>xue4</pinyin></item>
        
      	<item><char>xūn</char><pinyin>xun1</pinyin></item>
        <item><char>xún</char><pinyin>xun2</pinyin></item>
        <item><char>xǔn</char><pinyin>xun3</pinyin></item>
        <item><char>xùn</char><pinyin>xun4</pinyin></item>

        <item><char>xū</char><pinyin>xu1</pinyin></item>
        <item><char>xú</char><pinyin>xu2</pinyin></item>
        <item><char>xǔ</char><pinyin>xu3</pinyin></item>
        <item><char>xù</char><pinyin>xu4</pinyin></item>
        
      </group>
      <group key="y">
        
      	<item><char>yāng</char><pinyin>yang1</pinyin></item>
        <item><char>yáng</char><pinyin>yang2</pinyin></item>
        <item><char>yǎng</char><pinyin>yang3</pinyin></item>
        <item><char>yàng</char><pinyin>yang4</pinyin></item>
        
        <item><char>yān</char><pinyin>yan1</pinyin></item>
        <item><char>yán</char><pinyin>yan2</pinyin></item>
        <item><char>yǎn</char><pinyin>yan3</pinyin></item>
        <item><char>yàn</char><pinyin>yan4</pinyin></item>
        
        <item><char>yāo</char><pinyin>yao1</pinyin></item>
        <item><char>yáo</char><pinyin>yao2</pinyin></item>
        <item><char>yǎo</char><pinyin>yao3</pinyin></item>
        <item><char>yào</char><pinyin>yao4</pinyin></item>
        
        <item><char>yā</char><pinyin>ya1</pinyin></item>
        <item><char>yá</char><pinyin>ya2</pinyin></item>
        <item><char>yǎ</char><pinyin>ya3</pinyin></item>
        <item><char>yà</char><pinyin>ya4</pinyin></item>
        
        <item><char>yē</char><pinyin>ye1</pinyin></item>
        <item><char>yé</char><pinyin>ye2</pinyin></item>
        <item><char>yě</char><pinyin>ye3</pinyin></item>
        <item><char>yè</char><pinyin>ye4</pinyin></item>
        
        <item><char>yīng</char><pinyin>ying1</pinyin></item>
        <item><char>yíng</char><pinyin>ying2</pinyin></item>
        <item><char>yǐng</char><pinyin>ying3</pinyin></item>
        <item><char>yìng</char><pinyin>ying4</pinyin></item>
        
        <item><char>yīn</char><pinyin>yin1</pinyin></item>
        <item><char>yín</char><pinyin>yin2</pinyin></item>
        <item><char>yǐn</char><pinyin>yin3</pinyin></item>
        <item><char>yìn</char><pinyin>yin4</pinyin></item>
        
        <item><char>yī</char><pinyin>yi1</pinyin></item>
        <item><char>yí</char><pinyin>yi2</pinyin></item>
        <item><char>yǐ</char><pinyin>yi3</pinyin></item>
        <item><char>yì</char><pinyin>yi4</pinyin></item>
        
        <item><char>yōng</char><pinyin>yong1</pinyin></item>
        <item><char>yóng</char><pinyin>yong2</pinyin></item>
        <item><char>yǒng</char><pinyin>yong3</pinyin></item>
        <item><char>yòng</char><pinyin>yong4</pinyin></item>
        
      	<item><char>yōu</char><pinyin>you1</pinyin></item>
        <item><char>yóu</char><pinyin>you2</pinyin></item>
        <item><char>yǒu</char><pinyin>you3</pinyin></item>
        <item><char>yòu</char><pinyin>you4</pinyin></item>
        
      	<item><char>yuān</char><pinyin>yuan1</pinyin></item>
        <item><char>yuán</char><pinyin>yuan2</pinyin></item>
        <item><char>yuǎn</char><pinyin>yuan3</pinyin></item>
        <item><char>yuàn</char><pinyin>yuan4</pinyin></item>
        
      	<item><char>yuē</char><pinyin>yue1</pinyin></item>
        <item><char>yué</char><pinyin>yue2</pinyin></item>
        <item><char>yuě</char><pinyin>yue3</pinyin></item>
        <item><char>yuè</char><pinyin>yue4</pinyin></item>
        
      	<item><char>yūn</char><pinyin>yun1</pinyin></item>
        <item><char>yún</char><pinyin>yun2</pinyin></item>
        <item><char>yǔn</char><pinyin>yun3</pinyin></item>
        <item><char>yùn</char><pinyin>yun4</pinyin></item>
        
        <item><char>yū</char><pinyin>yu1</pinyin></item>
        <item><char>yú</char><pinyin>yu2</pinyin></item>
        <item><char>yǔ</char><pinyin>yu3</pinyin></item>
        <item><char>yù</char><pinyin>yu4</pinyin></item>
        
      </group>
      <group key="z">
        
      
      	<item><char>zāi</char><pinyin>zai1</pinyin></item>
        <item><char>zái</char><pinyin>zai2</pinyin></item>
        <item><char>zǎi</char><pinyin>zai3</pinyin></item>
        <item><char>zài</char><pinyin>zai4</pinyin></item>
        
        <item><char>zāng</char><pinyin>zang1</pinyin></item>
        <item><char>záng</char><pinyin>zang2</pinyin></item>
        <item><char>zǎng</char><pinyin>zang3</pinyin></item>
        <item><char>zàng</char><pinyin>zang4</pinyin></item>
        
        <item><char>zān</char><pinyin>zan1</pinyin></item>
        <item><char>zán</char><pinyin>zan2</pinyin></item>
        <item><char>zǎn</char><pinyin>zan3</pinyin></item>
        <item><char>zàn</char><pinyin>zan4</pinyin></item>
        
      	<item><char>zāo</char><pinyin>zao1</pinyin></item>
        <item><char>záo</char><pinyin>zao2</pinyin></item>
        <item><char>zǎo</char><pinyin>zao3</pinyin></item>
        <item><char>zào</char><pinyin>zao4</pinyin></item>
        
        <item><char>zā</char><pinyin>za1</pinyin></item>
        <item><char>zá</char><pinyin>za2</pinyin></item>
        <item><char>zǎ</char><pinyin>za3</pinyin></item>
        <item><char>zà</char><pinyin>za4</pinyin></item>
        
        <item><char>zē</char><pinyin>ze1</pinyin></item>
        <item><char>zé</char><pinyin>ze2</pinyin></item>
        <item><char>zě</char><pinyin>ze3</pinyin></item>
        <item><char>zè</char><pinyin>ze4</pinyin></item>
        
      	<item><char>zēi</char><pinyin>zei1</pinyin></item>
        <item><char>zéi</char><pinyin>zei2</pinyin></item>
        <item><char>zěi</char><pinyin>zei3</pinyin></item>
        <item><char>zèi</char><pinyin>zei4</pinyin></item>
        
        <item><char>zēng</char><pinyin>zeng1</pinyin></item>
        <item><char>zéng</char><pinyin>zeng2</pinyin></item>
        <item><char>zěng</char><pinyin>zeng3</pinyin></item>
        <item><char>zèng</char><pinyin>zeng4</pinyin></item>
        
        <item><char>zēn</char><pinyin>zen1</pinyin></item>
        <item><char>zén</char><pinyin>zen2</pinyin></item>
        <item><char>zěn</char><pinyin>zen3</pinyin></item>
        <item><char>zèn</char><pinyin>zen4</pinyin></item>
        
      	<item><char>zhāi</char><pinyin>zhai1</pinyin></item>
        <item><char>zhái</char><pinyin>zhai2</pinyin></item>
        <item><char>zhǎi</char><pinyin>zhai3</pinyin></item>
        <item><char>zhài</char><pinyin>zhai4</pinyin></item>
        
        <item><char>zhāng</char><pinyin>zhang1</pinyin></item>
        <item><char>zháng</char><pinyin>zhang2</pinyin></item>
        <item><char>zhǎng</char><pinyin>zhang3</pinyin></item>
        <item><char>zhàng</char><pinyin>zhang4</pinyin></item>
        
        <item><char>zhān</char><pinyin>zhan1</pinyin></item>
        <item><char>zhán</char><pinyin>zhan2</pinyin></item>
        <item><char>zhǎn</char><pinyin>zhan3</pinyin></item>
        <item><char>zhàn</char><pinyin>zhan4</pinyin></item>
        
      	<item><char>zhāo</char><pinyin>zhao1</pinyin></item>
        <item><char>zháo</char><pinyin>zhao2</pinyin></item>
        <item><char>zhǎo</char><pinyin>zhao3</pinyin></item>
        <item><char>zhào</char><pinyin>zhao4</pinyin></item>
        
        <item><char>zhā</char><pinyin>zha1</pinyin></item>
        <item><char>zhá</char><pinyin>zha2</pinyin></item>
        <item><char>zhǎ</char><pinyin>zha3</pinyin></item>
        <item><char>zhà</char><pinyin>zha4</pinyin></item>
        
      	<item><char>zhēi</char><pinyin>zhei1</pinyin></item>
        <item><char>zhéi</char><pinyin>zhei2</pinyin></item>
        <item><char>zhěi</char><pinyin>zhei3</pinyin></item>
        <item><char>zhèi</char><pinyin>zhei4</pinyin></item>
        
        <item><char>zhē</char><pinyin>zhe1</pinyin></item>
        <item><char>zhé</char><pinyin>zhe2</pinyin></item>
        <item><char>zhě</char><pinyin>zhe3</pinyin></item>
        <item><char>zhè</char><pinyin>zhe4</pinyin></item>
        
        <item><char>zhēng</char><pinyin>zheng1</pinyin></item>
        <item><char>zhéng</char><pinyin>zheng2</pinyin></item>
        <item><char>zhěng</char><pinyin>zheng3</pinyin></item>
        <item><char>zhèng</char><pinyin>zheng4</pinyin></item>
        
        <item><char>zhēn</char><pinyin>zhen1</pinyin></item>
        <item><char>zhén</char><pinyin>zhen2</pinyin></item>
        <item><char>zhěn</char><pinyin>zhen3</pinyin></item>
        <item><char>zhèn</char><pinyin>zhen4</pinyin></item>
        
      	<item><char>zhī</char><pinyin>zhi1</pinyin></item>
        <item><char>zhí</char><pinyin>zhi2</pinyin></item>
        <item><char>zhǐ</char><pinyin>zhi3</pinyin></item>
        <item><char>zhì</char><pinyin>zhi4</pinyin></item>
        
      	<item><char>zhōng</char><pinyin>zhong1</pinyin></item>
        <item><char>zhóng</char><pinyin>zhong2</pinyin></item>
        <item><char>zhǒng</char><pinyin>zhong3</pinyin></item>
        <item><char>zhòng</char><pinyin>zhong4</pinyin></item>
        
      	<item><char>zhōu</char><pinyin>zhou1</pinyin></item>
        <item><char>zhóu</char><pinyin>zhou2</pinyin></item>
        <item><char>zhǒu</char><pinyin>zhou3</pinyin></item>
        <item><char>zhòu</char><pinyin>zhou4</pinyin></item>
        
      	<item><char>zhuāi</char><pinyin>zhuai1</pinyin></item>
        <item><char>zhuái</char><pinyin>zhuai2</pinyin></item>
        <item><char>zhuǎi</char><pinyin>zhuai3</pinyin></item>
        <item><char>zhuài</char><pinyin>zhuai4</pinyin></item>
        
        <item><char>zhuāng</char><pinyin>zhuang1</pinyin></item>
        <item><char>zhuáng</char><pinyin>zhuang2</pinyin></item>
        <item><char>zhuǎng</char><pinyin>zhuang3</pinyin></item>
        <item><char>zhuàng</char><pinyin>zhuang4</pinyin></item>
        
        <item><char>zhuān</char><pinyin>zhuan1</pinyin></item>
        <item><char>zhuán</char><pinyin>zhuan2</pinyin></item>
        <item><char>zhuǎn</char><pinyin>zhuan3</pinyin></item>
        <item><char>zhuàn</char><pinyin>zhuan4</pinyin></item>
        
        <item><char>zhuā</char><pinyin>zhua1</pinyin></item>
        <item><char>zhuá</char><pinyin>zhua2</pinyin></item>
        <item><char>zhuǎ</char><pinyin>zhua3</pinyin></item>
        <item><char>zhuà</char><pinyin>zhua4</pinyin></item>
        
        <item><char>zhuī</char><pinyin>zhui1</pinyin></item>
        <item><char>zhuí</char><pinyin>zhui2</pinyin></item>
        <item><char>zhuǐ</char><pinyin>zhui3</pinyin></item>
        <item><char>zhuì</char><pinyin>zhui4</pinyin></item>
        
      	<item><char>zhūn</char><pinyin>zhun1</pinyin></item>
        <item><char>zhún</char><pinyin>zhun2</pinyin></item>
        <item><char>zhǔn</char><pinyin>zhun3</pinyin></item>
        <item><char>zhùn</char><pinyin>zhun4</pinyin></item>
        
      	<item><char>zhuō</char><pinyin>zhuo1</pinyin></item>
        <item><char>zhuó</char><pinyin>zhuo2</pinyin></item>
        <item><char>zhuǒ</char><pinyin>zhuo3</pinyin></item>
        <item><char>zhuò</char><pinyin>zhuo4</pinyin></item>
        
        <item><char>zhū</char><pinyin>zhu1</pinyin></item>
        <item><char>zhú</char><pinyin>zhu2</pinyin></item>
        <item><char>zhǔ</char><pinyin>zhu3</pinyin></item>
        <item><char>zhù</char><pinyin>zhu4</pinyin></item>
        
        <item><char>zī</char><pinyin>zi1</pinyin></item>
        <item><char>zí</char><pinyin>zi2</pinyin></item>
        <item><char>zǐ</char><pinyin>zi3</pinyin></item>
        <item><char>zì</char><pinyin>zi4</pinyin></item>
        
      	<item><char>zōng</char><pinyin>zong1</pinyin></item>
        <item><char>zóng</char><pinyin>zong2</pinyin></item>
        <item><char>zǒng</char><pinyin>zong3</pinyin></item>
        <item><char>zòng</char><pinyin>zong4</pinyin></item>
        
      	<item><char>zōu</char><pinyin>zou1</pinyin></item>
        <item><char>zóu</char><pinyin>zou2</pinyin></item>
        <item><char>zǒu</char><pinyin>zou3</pinyin></item>
        <item><char>zòu</char><pinyin>zou4</pinyin></item>
        
      	<item><char>zuān</char><pinyin>zuan1</pinyin></item>
        <item><char>zuán</char><pinyin>zuan2</pinyin></item>
        <item><char>zuǎn</char><pinyin>zuan3</pinyin></item>
        <item><char>zuàn</char><pinyin>zuan4</pinyin></item>
        
      	<item><char>zuī</char><pinyin>zui1</pinyin></item>
        <item><char>zuí</char><pinyin>zui2</pinyin></item>
        <item><char>zuǐ</char><pinyin>zui3</pinyin></item>
        <item><char>zuì</char><pinyin>zui4</pinyin></item>
        
      	<item><char>zūn</char><pinyin>zun1</pinyin></item>
        <item><char>zún</char><pinyin>zun2</pinyin></item>
        <item><char>zǔn</char><pinyin>zun3</pinyin></item>
        <item><char>zùn</char><pinyin>zun4</pinyin></item>
        
      	<item><char>zuō</char><pinyin>zuo1</pinyin></item>
        <item><char>zuó</char><pinyin>zuo2</pinyin></item>
        <item><char>zuǒ</char><pinyin>zuo3</pinyin></item>
        <item><char>zuò</char><pinyin>zuo4</pinyin></item>

        <item><char>zū</char><pinyin>zu1</pinyin></item>
        <item><char>zú</char><pinyin>zu2</pinyin></item>
        <item><char>zǔ</char><pinyin>zu3</pinyin></item>
        <item><char>zù</char><pinyin>zu4</pinyin></item>
        
      </group>
    </map>
  </xsl:variable>
  
</xsl:stylesheet>