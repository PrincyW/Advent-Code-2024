require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/3/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  memory = URI.open(url, "Cookie" => cookie).read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end

#2 Method

puts "*************** PART 1 ***************"

def sum_multiplications(a_string)
  # Selection of the right multiplicators
  multiplications = a_string.scan(/mul\(\d{1,3},\d{1,3}\)/)
  sum = 0
  # Procession of the array
  multiplications.each do |mul|
    xy = mul.scan(/\d{1,3}/) # Selection of the numbers to multiply
    result = xy[0].to_i * xy[1].to_i
    sum = sum + result
  end
  return sum
end
puts "Original input : The sum of multiplication is #{sum_multiplications(memory)}"

# ************ TESTS ***************
example1 = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
example2 = "}mul(620,236)where()*@}!&[mul(589,126)]&^]mul(260,42 )when() when()$ ?{/^*mul(335,2509)>"

puts "Example 1: The sum of multiplication is #{sum_multiplications(example1)}"
puts "Example 2: The sum of multiplication is #{sum_multiplications(example2)}"


# PART 2

puts "*************** PART 2 ***************"

# Extraction of the correct "muls"

def extract_safe_muls(a_string)
  # Define the result array
  result = []

  # Split the string into sections based on "don't()"
  sections = a_string.split(/don't\(\)/)
  sections.each_with_index do |section, index|
    # Check if we're in the first section (before the first "don't()")
    if index == 0
      # Extract "mul(x,y)" in the section before the first "don't()"
      result.concat(section.scan(/mul\(\d{1,3},\d{1,3}\)/))

    else
      match_data = section.match(/(do\(\))(.*)/)
      if match_data
        valid_parts = match_data[2]
        muls = valid_parts.scan(/mul\(\d{1,3},\d{1,3}\)/)
        result.concat(muls)
      end
    end
  end

  result
end

def valid_parts(section)
  match_data = section.match(/(do\(\))(.*)/)
  if match_data
    valid_parts = match_data[2]
    muls = valid_parts.scan(/mul\(\d{1,3},\d{1,3}\)/)
  end
  return muls
end


# Sum of multiplications
def sum_safe_mul (a_string)
  safe_muls = extract_safe_muls(a_string)
  sum = 0
  # Procession of the array
  safe_muls.each do |mul|
    xy = mul.scan(/\d{1,3}/) # Selection of the numbers to multiply
    result = xy[0].to_i * xy[1].to_i
    sum = sum + result
  end
  return sum
end

# TESTS
example3 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
example4 = "}mul(620,236)where()*@}!&[mul(589,126)]&^]mul(260,42)when() when()$ ?{/^*mul(335,250)>,@!<{when()+-$don't()*'^?+>>/%:mul(422,738),mul(694,717);~;%<[why()>@-mul(417,219)?&who(474,989){select()-{#mul(366,638)mul(773,126)/*{mul(757,799)]when()mul(778,467)^mul(487,365)]*'{where(952,954){?who()who()when()mul(172,666)#<do()why()~&why())'< {mul(33,475)}mul(916,60)what()?when()>?$,-mul(250,228)(]when()}<mul(817,274)'{})mul(836,930):@how()]!@'select()~?mul(514,457)from()&what()what()when()mul(872,884)select()<select()from()'!who()mul(11,966)/from()(~}#,"
section1 = "}mul(620,236)where()*@}!&[mul(589,126)]&^]mul(260,42)when() when()$ ?{/^*mul(335,250)>,@!<{when()+-$"
section2 = "*'^?+>>/%:mul(422,738),mul(694,717);~;%<[why()>@-mul(417,219)?&who(474,989){select()-{#mul(366,638)mul(773,126)/*{mul(757,799)]when()mul(778,467)^mul(487,365)]*'{where(952,954){?who()who()when()mul(172,666)#<do()why()~&why())'< {mul(33,475)}mul(916,60)what()?when()>?$,-mul(250,228)(]when()}<mul(817,274)'{})mul(836,930):@how()]!@'select()~?mul(514,457)from()&what()what()when()mul(872,884)select()<select()from()'!who()mul(11,966)/from()(~}#,(*from()mul(941,908)#>mul(760,139)mul(892,161)!'@[%when()<(mul(775,872)+~#)//$select()mul(946,63)how()??select()?from(277,915)~'mul(637,565)~mul(881,294)who()what()}mul(995,866)?mul(952,57)who()mul(387,599)mul(46,724)who()[how()select()mul(992,19)'~mul(909,687)where()mul(953,804)from()/;where(474,270)from()}mul(907,410)&(&what()%{mul(192,898)who()-,mul(196,400)#--{%]how()mul(144,141)~@[when()!%:[mul(377,942)^*mul(89,46)who()<}when()?!'%mul(172,448){]@mul(351,18)~]&!$mul(490,127)/]] }}mul(851,465)when()*-why()what()))@+<mul(465,978):*>^<-select()do()%#+;%:mul(549,307)<where(154,242)(;< /who()mul(426,943)mul(477,782)*?do() mul(745,445)@  (how()$where()mul(118,902)when()when()}!how()"
section3 = ";mul(523,781)mul(350,886)!}from()>#mul(968,958)mul(125,903)what()who()$where()%who()how()mul(139,859)<&/+how()mul(339,100)@(<?select()+))~mul(548,608)select(166,582) }where()$how(),mul(21,567)from()mul(798,591)+-;][)from()mul(398,197):<why()when()why()[mul(296,785)where()%^(how()select()&:mul(833,729) <# ,mul(858,55)}(~{<;how()^mul(789,160)^where()'mul(320,473)#&mul(281,366)?mul(415,485):::[mul(550,20)["
section4 = "what(){who(197,721)when()!how(748,315)&-{mul(109,947)?^]({mul(915,217)what(),],what()<"
section5 = "<-/^<:<mul(264,899)}^from()%mul(137,563)?select(478,659)why(857,355)(%*]~mul(563,802)$&when()mul(121,341)from();~what(495,238)'from()mul(533,553)from())<!+{'&]mul(605,211)}why()select()(mul(607,201)</&how()%-what()?<;mul(592,310)$^(:;%where(873,478)~mul(565,816)mul(52,983)select()who()>:mul(306,909)?)--what()who()/)*mul(724,497)'how()from()mul(489,24)${/%/:how()>(mul(397,282)}?from()who()$/'mul(86,511)mul(463,903);(^@mul(302,904)-,who()what()from(892,368)where()-mul(707,359)/who()/';;++;mul(687,987)^:select()select():mul(915,123)<]!:'/[select()mul(809,835)why()when())* mul(139,828))why()who() ,mul(807,713)where()><?select(42,854)what()*"
section6 = "%~%&mul(363,160)%$~"
section7 = "}+^#+,what(296,891)+when()mul(672,112)/}/*?/,mul(185,994)from()]-?mul(233+mul(234,464)((,how()* mul(647,845):^$?$#&~mul(994,732);(from();+how()mul(581,905)mul(458,49)from()mul(539,976)@mul(28,592)$ where(777,812)>:mul(350,287)where()-where()+:~{who() mul(437,102) %when()select(),mul(813,883)]when()>(from()don't()]where()@/:how())'#mul(337,905)*>>*!don't()>(+}:mul(488,283)<~<what(),>>mul(703,476),what()@(} mul(487,921)from()select()why()mul(761,203)who()how()mul(32,930)[how()do())/}where()mul(778,306))mul(593,810)mul(629,319)';$mul(122,109){ ^^-mul(720,536)?!+mul(519,541)$'/@who()!~where()$mul(461,98)
$[mul(647,228)^why()how()>why()^{mul:from()%who()/$%}%mul(810,82)]^+<?*&'mul(191,150)do()mul(460,419)]mul(349,490)why()&from()),)~%}mul(279,311)mul(632,181)$what()~,+mul(857,4)$select()?^mul(114,490),why()],]#}select()^"
section8 = "/$mul(502,531)!(when()+ when()^mul(923,724)<:>[mul(377,189)){&select()/(select()$$mul(343,443)who():-"
section9 = "}how()'how()]:select()why(){mul(963,385)/^why()who()^mul(131,676)mul(113,570)~';*mul(853,789)${>%{:](*$mul(736,139)??%^where()what()~]mul(447,113)"
section10 = "(^;select(921,651)<[#why()mul(912,658)/{&from()where()-what()why()who()mul(587,480)]!how()]from()mul(389,102)'@mul(200,564)>#/,#;mul(24,400){):,!+;];mul(595,551)!who()how()]$select()mul(969,989)/?%mul(899,264)@what(507,249)&mul]~*mul(354,715)>,mul(914,563)>'};~!select()"
section11 = "&{mul(50,819)select()@>:+ when(501,666)!mul(970,506)who()mul? }~[when()%mul(358,287)!mul(291,276):#what()::mul(946,666)'??;+'/>'mul(31,79)~#*}#-}/where(532,773)mul(919,720)where()@^<mul(970,193)mul(439,354)<^::why(){where()what() mul(427,831)??why()what()[?#&, "
section12 = "select()how()when(694,382)#)mul(353,771)where()@mul(524,353)'from()}how(){#?mul(737,977)#mul(73 !&&}?^ mul(977,323)&:/<mul(744,883)*({mul(49,407)how()]<+}@when()/}do()mul(556,662)?]mul(134,496)+?{{@mul(162,240(!~select(287,764)~/when()mul(520,269)?;how()&:{),,:mul(13,440)'select()'{mul(859,860)what():who()+mul(448,184)&-!+from()%$?]mul(707,90)?/,&why();who()#(/mul(428',;-mul(662,231)(who()where()when()&:<mul(896,482)&what()select()mul(842,701)where()?,<who()-mul(590,699)where()>@]&#how(){^;mul(561,111)^&^? select()[why(803,159)(*mul(716,153)};{]how()[#+',mul(883?:from()why()what()?%]!why(393,804)~mul(231,805)how()when()why()@select()mul(552,136)$;[!where(454,987)who()what()mul(555,591)mulfrom()?from()^select()mul(467,281)mul(702,811)}}{;"
section13 = "[mul(543,7)from(608,658)&^?mul(144,343)from()who()-?<select()*^+mul*'??why()^^^%mul(982,231)who()/+select()+?mul(964,717^<&;)where()where()]how()select()?mul(312,551):mul(587from():}where()why()# %mul(973,85)&-)when()why()mul(321,137)>&"
section14 = "mul(860,384)where(611,825)%&+,^{<mul(540,230)]]from()$}/select()(*)mul(747,508)select(323,184)/+#?mul }!<-why(689,967)where(833,654)-]-mul(474,335)+{mul(748,138) <?#[))%mul(973,899)where()@{(mul(252,461)how()+mul(278,445):mul(432who()>where()@select()%}%what()}do()/who())}where(740,982)#-why():,mul(523,265)+select()[):]when():mul(200,994)}when(436,935)<%;)&!mul(156,920)when()mul(822,281)~>mul(3,591)when()*select()$mul(993,139)where()(!$why():%<where()mul(315,53){,when(533,723)who(){mul(561,236)@*]why()why(390,506)'why(868,612)~how()mul(774,675))%,%@select()$[[who()mul(366,787)/[{'/do()/how()'when() @/mul(295,622)from()^mul(180,419)mul(280,790)who())]what()%'<when()mul(909,222):*]where()"
section15 = "hy()!~-mul+^$how()^[mul(98,91)what()select(611,630)>+from()mul(167,958),;select(579,937)from()?{?from(644,816)mul(675,905)why()mul(787,123)%mul(982,476)~mul(613,499)#;)'mul<who(664,651))&mul(461,433)]< who()&mul(418,980)mul(835,479)}mul(852,92) who()who(859,651)~>how(280,254)mul(393,812)#mul(54,319)(;what()%/@(mul(23,133)mul(401,60)who()$mul(615,621)]@what()$mul(77,795)from()+{!+!;mul(935,990)select()+!>mul(843,623)what()]$,/#)/mul(374,785)@ /"



puts "Extract safe muls from original input"
puts extract_safe_muls(memory)
puts "Original input : The sum of multiplications WITH conditions is #{sum_safe_mul(memory)}"
puts "***********************************\n"

puts "Extract safe muls example 3"
puts extract_safe_muls(example3)
puts "Example 3 : The sum of multiplications WITH conditions is #{sum_safe_mul(example3)}"
puts "***********************************\n"

puts "Extract safe muls example 4"
puts extract_safe_muls(example4)
puts "Example 4 : The sum of multiplications WITH conditions is #{sum_safe_mul(example4)}"
puts "***********************************\n"

puts "Extract safe muls section 2"
puts valid_parts(section2)
puts "***********************************\n"

puts "Extract safe muls section 3"
puts valid_parts(section3)
puts "***********************************\n"

puts "Extract safe muls section 4"
puts valid_parts(section4)
puts "***********************************\n"

puts "Extract safe muls section 5"
puts valid_parts(section5)
puts "***********************************\n"

puts "Extract safe muls section 6"
puts valid_parts(section6)
puts "***********************************\n"

puts "Extract safe muls section 7"
puts valid_parts(section7)
puts "***********************************\n"

puts "Extract safe muls section 8"
puts valid_parts(section8)
puts "***********************************\n"

puts "Extract safe muls section 9"
puts valid_parts(section9)
puts "***********************************\n"

puts "Extract safe muls section 10"
puts valid_parts(section10)
puts "***********************************\n"

puts "Extract safe muls section 11"
puts valid_parts(section11)
puts "***********************************\n"

puts "Extract safe muls section 12"
puts valid_parts(section12)
puts "***********************************\n"

puts "Extract safe muls section 13"
puts valid_parts(section13)
puts "***********************************\n"

puts "Extract safe muls section 14"
puts valid_parts(section14)
puts "***********************************\n"

puts "Extract safe muls section 15"
puts valid_parts(section15)
puts "***********************************\n"
