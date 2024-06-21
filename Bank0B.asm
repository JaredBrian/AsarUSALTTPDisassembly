; ==============================================================================

; Bank 0B
; $058000-$05FFFF
org $0B8000

; Overworld map data
; Other misc functions

; ==============================================================================

; $058000-$058003 DATA
;org $0B8000
OverworldMap32_Screen00_High:
{
    incbin "bin/ow/screen00-h.bin" ; size: 0x0004
}

; $058004-$0580D5 DATA
;org $0B8004
OverworldMap32_Screen00_Low:
{
    incbin "bin/ow/screen00-l.bin" ; size: 0x00D2
}

; $0580D6-$0580D9 DATA
;org $0B80D6
OverworldMap32_Screen01_High:
{
    incbin "bin/ow/screen01-h.bin" ; size: 0x0004
}

; $0580DA-$0581C1 DATA
;org $0B80DA
OverworldMap32_Screen01_Low:
{
    incbin "bin/ow/screen01-l.bin" ; size: 0x00E8
}

; $0581C2-$058237 DATA
;org $0B81C2
OverworldMap32_Screen02_High:
{
    incbin "bin/ow/screen02-h.bin" ; size: 0x0076
}

; $058238-$058315 DATA
;org $0B8238
OverworldMap32_Screen02_Low:
{
    incbin "bin/ow/screen02-l.bin" ; size: 0x00DE
}

; $058316-$05833F DATA
;org $0B8316
OverworldMap32_Screen03_High:
{
    incbin "bin/ow/screen03-h.bin" ; size: 0x002A
}

; $058340-$0583E9 DATA
;org $0B8340
OverworldMap32_Screen03_Low:
{
    incbin "bin/ow/screen03-l.bin" ; size: 0x00AA
}

; $0583EA-$05845F DATA
;org $0B83EA
OverworldMap32_Screen04_High:
{
    incbin "bin/ow/screen04-h.bin" ; size: 0x0076
}

; $058460-$05850D DATA
;org $0B8460
OverworldMap32_Screen04_Low:
{
    incbin "bin/ow/screen04-l.bin" ; size: 0x00AE
}

; $05850E-$0585A2 DATA
;org $0B850E
OverworldMap32_Screen05_High:
{
    incbin "bin/ow/screen05-h.bin" ; size: 0x0095
}

; $0585A3-$058670 DATA
;org $0B85A3
OverworldMap32_Screen05_Low:
{
    incbin "bin/ow/screen05-l.bin" ; size: 0x00CE
}

; $058671-$058723 DATA
;org $0B8671
OverworldMap32_Screen06_High:
{
    incbin "bin/ow/screen06-h.bin" ; size: 0x00B3
}

; $058724-$05880E DATA
;org $0B8724
OverworldMap32_Screen06_Low:
{
    incbin "bin/ow/screen06-l.bin" ; size: 0x00EB
}

; $05880F-$0588DF DATA
;org $0B880F
OverworldMap32_Screen07_High:
{
    incbin "bin/ow/screen07-h.bin" ; size: 0x00D1
}

; $0588E0-$0589D2 DATA
;org $0B88E0
OverworldMap32_Screen07_Low:
{
    incbin "bin/ow/screen07-l.bin" ; size: 0x00F3
}

; $0589D3-$058A90 DATA
;org $0B89D3
OverworldMap32_Screen08_High:
{
    incbin "bin/ow/screen08-h.bin" ; size: 0x00BE
}

; $058A91-$058B8F DATA
;org $0B8A91
OverworldMap32_Screen08_Low:
{
    incbin "bin/ow/screen08-l.bin" ; size: 0x00FF
}

; $058B90-$058C34 DATA
;org $0B8B90
OverworldMap32_Screen09_High:
{
    incbin "bin/ow/screen09-h.bin" ; size: 0x00A5
}

; $058C35-$058D23 DATA
;org $0B8C35
OverworldMap32_Screen09_Low:
{
    incbin "bin/ow/screen09-l.bin" ; size: 0x00EF
}

; $058D24-$058DF5 DATA
;org $0B8D24
OverworldMap32_Screen0B_High:
{
    incbin "bin/ow/screen0B-h.bin" ; size: 0x00D2
}

; $058DF6-$058EE2 DATA
;org $0B8DF6
OverworldMap32_Screen0B_Low:
{
    incbin "bin/ow/screen0B-l.bin" ; size: 0x00ED
}

; $058EE3-$058F86 DATA
;org $0B8EE3
OverworldMap32_Screen0C_High:
{
    incbin "bin/ow/screen0C-h.bin" ; size: 0x00A4
}

; $058F87-$05906F DATA
;org $0B8F87
OverworldMap32_Screen0C_Low:
{
    incbin "bin/ow/screen0C-l.bin" ; size: 0x00E9
}

; $059070-$059117 DATA
;org $0B9070
OverworldMap32_Screen0D_High:
{
    incbin "bin/ow/screen0D-h.bin" ; size: 0x00A8
}

; $059118-$0591E9 DATA
;org $0B9118
OverworldMap32_Screen0D_Low:
{
    incbin "bin/ow/screen0D-l.bin" ; size: 0x00D2
}

; $0591EA-$0592CE DATA
;org $0B91EA
OverworldMap32_Screen0E_High:
{
    incbin "bin/ow/screen0E-h.bin" ; size: 0x00E5
}

; $0592CF-$0593CB DATA
;org $0B92CF
OverworldMap32_Screen0E_Low:
{
    incbin "bin/ow/screen0E-l.bin" ; size: 0x00FD
}

; $0593CC-$059464 DATA
;org $0B93CC
OverworldMap32_Screen0F_High:
{
    incbin "bin/ow/screen0F-h.bin" ; size: 0x0099
}

; $059465-$059526 DATA
;org $0B9465
OverworldMap32_Screen0F_Low:
{
    incbin "bin/ow/screen0F-l.bin" ; size: 0x00C2
}

; $059527-$0595E6 DATA
;org $0B9527
OverworldMap32_Screen10_High:
{
    incbin "bin/ow/screen10-h.bin" ; size: 0x00C0
}

; $0595E7-$0596D4 DATA
;org $0B95E7
OverworldMap32_Screen10_Low:
{
    incbin "bin/ow/screen10-l.bin" ; size: 0x00EE
}

; $0596D5-$059774 DATA
;org $0B96D5
OverworldMap32_Screen13_High:
{
    incbin "bin/ow/screen13-h.bin" ; size: 0x00A0
}

; $059775-$059842 DATA
;org $0B9775
OverworldMap32_Screen13_Low:
{
    incbin "bin/ow/screen13-l.bin" ; size: 0x00CE
}

; $059843-$0598C6 DATA
;org $0B9843
OverworldMap32_Screen14_High:
{
    incbin "bin/ow/screen14-h.bin" ; size: 0x0084
}

; $0598C7-$05998B DATA
;org $0B98C7
OverworldMap32_Screen14_Low:
{
    incbin "bin/ow/screen14-l.bin" ; size: 0x00C5
}

; $05998C-$059A64 DATA
;org $0B998C
OverworldMap32_Screen15_High:
{
    incbin "bin/ow/screen15-h.bin" ; size: 0x00D9
}

; $059A65-$059B54 DATA
;org $0B9A65
OverworldMap32_Screen15_Low:
{
    incbin "bin/ow/screen15-l.bin" ; size: 0x00F0
}

; $059B55-$059C17 DATA
;org $0B9B55
OverworldMap32_Screen16_High:
{
    incbin "bin/ow/screen16-h.bin" ; size: 0x00C3
}

; $059C18-$059D06 DATA
;org $0B9C18
OverworldMap32_Screen16_Low:
{
    incbin "bin/ow/screen16-l.bin" ; size: 0x00EF
}

; $059D07-$059DAB DATA
;org $0B9D07
OverworldMap32_Screen18_High:
{
    incbin "bin/ow/screen18-h.bin" ; size: 0x00A5
}

; $059DAC-$059E88 DATA
;org $0B9DAC
OverworldMap32_Screen18_Low:
{
    incbin "bin/ow/screen18-l.bin" ; size: 0x00DD
}

; $059E89-$059F38 DATA
;org $0B9E89
OverworldMap32_Screen19_High:
{
    incbin "bin/ow/screen19-h.bin" ; size: 0x00B0
}

; $059F39-$05A015 DATA
;org $0B9F39
OverworldMap32_Screen19_Low:
{
    incbin "bin/ow/screen19-l.bin" ; size: 0x00DD
}

; $05A016-$05A106 DATA
;org $0BA016
OverworldMap32_Screen1A_High:
{
    incbin "bin/ow/screen1A-h.bin" ; size: 0x00F1
}

; $05A107-$05A208 DATA
;org $0BA107
OverworldMap32_Screen1A_Low:
{
    incbin "bin/ow/screen1A-l.bin" ; size: 0x0102
}

; $05A209-$05A2C0 DATA
;org $0BA209
OverworldMap32_Screen1B_High:
{
    incbin "bin/ow/screen1B-h.bin" ; size: 0x00B8
}

; $05A2C1-$05A3A5 DATA
;org $0BA2C1
OverworldMap32_Screen1B_Low:
{
    incbin "bin/ow/screen1B-l.bin" ; size: 0x00E5
}

; $05A3A6-$05A45D DATA
;org $0BA3A6
OverworldMap32_Screen1C_High:
{
    incbin "bin/ow/screen1C-h.bin" ; size: 0x00B8
}

; $05A45E-$05A542 DATA
;org $0BA45E
OverworldMap32_Screen1C_Low:
{
    incbin "bin/ow/screen1C-l.bin" ; size: 0x00E5
}

; $05A543-$05A621 DATA
;org $0BA543
OverworldMap32_Screen1D_High:
{
    incbin "bin/ow/screen1D-h.bin" ; size: 0x00DF
}

; $05A622-$05A713 DATA
;org $0BA622
OverworldMap32_Screen1D_Low:
{
    incbin "bin/ow/screen1D-l.bin" ; size: 0x00F2
}

; $05A714-$05A745 DATA
;org $0BA714
OverworldMap32_Screen1E_High:
{
    incbin "bin/ow/screen1E-h.bin" ; size: 0x0032
}

; $05A746-$05A818 DATA
;org $0BA746
OverworldMap32_Screen1E_Low:
{
    incbin "bin/ow/screen1E-l.bin" ; size: 0x00D3
}

; $05A819-$05A869 DATA
;org $0BA819
OverworldMap32_Screen1F_High:
{
    incbin "bin/ow/screen1F-h.bin" ; size: 0x0051
}

; $05A86A-$05A94D DATA
;org $0BA86A
OverworldMap32_Screen1F_Low:
{
    incbin "bin/ow/screen1F-l.bin" ; size: 0x00E4
}

; $05A94E-$05A9FA DATA
;org $0BA94E
OverworldMap32_Screen20_High:
{
    incbin "bin/ow/screen20-h.bin" ; size: 0x00AD
}

; $05A9FB-$05AACD DATA
;org $0BA9FB
OverworldMap32_Screen20_Low:
{
    incbin "bin/ow/screen20-l.bin" ; size: 0x00D3
}

; $05AACE-$05AB78 DATA
;org $0BAACE
OverworldMap32_Screen21_High:
{
    incbin "bin/ow/screen21-h.bin" ; size: 0x00AB
}

; $05AB79-$05AC5E DATA
;org $0BAB79
OverworldMap32_Screen21_Low:
{
    incbin "bin/ow/screen21-l.bin" ; size: 0x00E6
}

; $05AC5F-$05AD2D DATA
;org $0BAC5F
OverworldMap32_Screen22_High:
{
    incbin "bin/ow/screen22-h.bin" ; size: 0x00CF
}

; $05AD2E-$05AE21 DATA
;org $0BAD2E
OverworldMap32_Screen22_Low:
{
    incbin "bin/ow/screen22-l.bin" ; size: 0x00F4
}

; $05AE22-$05AECC DATA
;org $0BAE22
OverworldMap32_Screen23_High:
{
    incbin "bin/ow/screen23-h.bin" ; size: 0x00AB
}

; $05AECD-$05AF9F DATA
;org $0BAECD
OverworldMap32_Screen23_Low:
{
    incbin "bin/ow/screen23-l.bin" ; size: 0x00D3
}

; $05AFA0-$05B063 DATA
;org $0BAFA0
OverworldMap32_Screen24_High:
{
    incbin "bin/ow/screen24-h.bin" ; size: 0x00C4
}

; $05B064-$05B13F DATA
;org $0BB064
OverworldMap32_Screen24_Low:
{
    incbin "bin/ow/screen24-l.bin" ; size: 0x00DC
}

; $05B140-$05B203 DATA
;org $0BB140
OverworldMap32_Screen26_High:
{
    incbin "bin/ow/screen26-h.bin" ; size: 0x00C4
}

; $05B204-$05B2F2 DATA
;org $0BB204
OverworldMap32_Screen26_Low:
{
    incbin "bin/ow/screen26-l.bin" ; size: 0x00EF
}

; $05B2F3-$05B3C9 DATA
;org $0BB2F3
OverworldMap32_Screen27_High:
{
    incbin "bin/ow/screen27-h.bin" ; size: 0x00D7
}

; $05B3CA-$05B4B0 DATA
;org $0BB3CA
OverworldMap32_Screen27_Low:
{
    incbin "bin/ow/screen27-l.bin" ; size: 0x00E7
}

; $05B4B1-$05B566 DATA
;org $0BB4B1
OverworldMap32_Screen28_High:
{
    incbin "bin/ow/screen28-h.bin" ; size: 0x00B6
}

; $05B567-$05B643 DATA
;org $0BB567
OverworldMap32_Screen28_Low:
{
    incbin "bin/ow/screen28-l.bin" ; size: 0x00DD
}

; $05B644-$05B717 DATA
;org $0BB644
OverworldMap32_Screen29_High:
{
    incbin "bin/ow/screen29-h.bin" ; size: 0x00D4
}

; $05B718-$05B7FF DATA
;org $0BB718
OverworldMap32_Screen29_Low:
{
    incbin "bin/ow/screen29-l.bin" ; size: 0x00E8
}

; $05B800-$05B8D2 DATA
;org $0BB800
OverworldMap32_Screen2D_High:
{
    incbin "bin/ow/screen2D-h.bin" ; size: 0x00D3
}

; $05B8D3-$05B9BA DATA
;org $0BB8D3
OverworldMap32_Screen2D_Low:
{
    incbin "bin/ow/screen2D-l.bin" ; size: 0x00E8
}

; $05B9BB-$05BA24 DATA
;org $0BB9BB
OverworldMap32_Screen30_High:
{
    incbin "bin/ow/screen30-h.bin" ; size: 0x006A
}

; $05BA25-$05BAFD DATA
;org $0BBA25
OverworldMap32_Screen30_Low:
{
    incbin "bin/ow/screen30-l.bin" ; size: 0x00D9
}

; $05BAFE-$05BB3B DATA
;org $0BBAFE
OverworldMap32_Screen31_High:
{
    incbin "bin/ow/screen31-h.bin" ; size: 0x003E
}

; $05BB3C-$05BBFD DATA
;org $0BBB3C
OverworldMap32_Screen31_Low:
{
    incbin "bin/ow/screen31-l.bin" ; size: 0x00C2
}

; $05BBFE-$05BCD9 DATA
;org $0BBBFE
OverworldMap32_Screen32_High:
{
    incbin "bin/ow/screen32-h.bin" ; size: 0x00DC
}

; $05BCDA-$05BDC6 DATA
;org $0BBCDA
OverworldMap32_Screen32_Low:
{
    incbin "bin/ow/screen32-l.bin" ; size: 0x00ED
}

; $05BDC7-$05BEAB DATA
;org $0BBDC7
OverworldMap32_Screen35_High:
{
    incbin "bin/ow/screen35-h.bin" ; size: 0x00E5
}

; $05BEAC-$05BFA0 DATA
;org $0BBEAC
OverworldMap32_Screen35_Low:
{
    incbin "bin/ow/screen35-l.bin" ; size: 0x00F5
}

; $05BFA1-$05C08A DATA
;org $0BBFA1
OverworldMap32_Screen36_High:
{
    incbin "bin/ow/screen36-h.bin" ; size: 0x00EA
}

; $05C08B-$05C18E DATA
;org $0BC08B
OverworldMap32_Screen36_Low:
{
    incbin "bin/ow/screen36-l.bin" ; size: 0x0104
}

; $05C18F-$05C1FF DATA
;org $0BC18F
OverworldMap32_Screen38_High:
{
    incbin "bin/ow/screen38-h.bin" ; size: 0x0071
}

; $05C200-$05C2A3 DATA
;org $0BC200
OverworldMap32_Screen38_Low:
{
    incbin "bin/ow/screen38-l.bin" ; size: 0x00A4
}

; $05C2A4-$05C2FF DATA
;org $0BC2A4
OverworldMap32_Screen39_High:
{
    incbin "bin/ow/screen39-h.bin" ; size: 0x005C
}

; $05C300-$05C3B7 DATA
;org $0BC300
OverworldMap32_Screen39_Low:
{
    incbin "bin/ow/screen39-l.bin" ; size: 0x00B8
}

; $05C3B8-$05C499 DATA
;org $0BC3B8
OverworldMap32_Screen3A_High:
{
    incbin "bin/ow/screen3A-h.bin" ; size: 0x00E2
}

; $05C49A-$05C58F DATA
;org $0BC49A
OverworldMap32_Screen3A_Low:
{
    incbin "bin/ow/screen3A-l.bin" ; size: 0x00F6
}

; $05C590-$05C672 DATA
;org $0BC590
OverworldMap32_Screen3D_High:
{
    incbin "bin/ow/screen3D-h.bin" ; size: 0x00E3
}

; $05C673-$05C76B DATA
;org $0BC673
OverworldMap32_Screen3D_Low:
{
    incbin "bin/ow/screen3D-l.bin" ; size: 0x00F9
}

; $05C76C-$05C847 DATA
;org $0BC76C
OverworldMap32_Screen3E_High:
{
    incbin "bin/ow/screen3E-h.bin" ; size: 0x00DC
}

; $05C848-$05C93E DATA
;org $0BC848
OverworldMap32_Screen3E_Low:
{
    incbin "bin/ow/screen3E-l.bin" ; size: 0x00F7
}

; $05C93F-$05C947 DATA
;org $0BC93F
OverworldMap32_Screen40_High:
{
    incbin "bin/ow/screen40-h.bin" ; size: 0x0009
}

; $05C948-$05CA18 DATA
;org $0BC948
OverworldMap32_Screen40_Low:
{
    incbin "bin/ow/screen40-l.bin" ; size: 0x00D1
}

; $05CA19-$05CA77 DATA
;org $0BCA19
OverworldMap32_Screen41_High:
{
    incbin "bin/ow/screen41-h.bin" ; size: 0x005F
}

; $05CA78-$05CB59 DATA
;org $0BCA78
OverworldMap32_Screen41_Low:
{
    incbin "bin/ow/screen41-l.bin" ; size: 0x00E2
}

; $05CB5A-$05CBE2 DATA
;org $0BCB5A
OverworldMap32_Screen42_High:
{
    incbin "bin/ow/screen42-h.bin" ; size: 0x0089
}

; $05CBE3-$05CCEF DATA
;org $0BCBE3
OverworldMap32_Screen42_Low:
{
    incbin "bin/ow/screen42-l.bin" ; size: 0x00ED
}

; $05CCD0-$05CD57 DATA
;org $0BCCD0
OverworldMap32_Screen43_High:
{
    incbin "bin/ow/screen43-h.bin" ; size: 0x0088
}

; $05CD58-$05CE12 DATA
;org $0BCD58
OverworldMap32_Screen43_Low:
{
    incbin "bin/ow/screen43-l.bin" ; size: 0x00BB
}

; $05CE13-$05CEAF DATA
;org $0BCE13
OverworldMap32_Screen44_High:
{
    incbin "bin/ow/screen44-h.bin" ; size: 0x009D
}

; $05CEB0-$05CF6B DATA
;org $0BCEB0
OverworldMap32_Screen44_Low:
{
    incbin "bin/ow/screen44-l.bin" ; size: 0x00BC
}

; $05CF6C-$05CFF5 DATA
;org $0BCF6C
OverworldMap32_Screen45_High:
{
    incbin "bin/ow/screen45-h.bin" ; size: 0x008A
}

; $05CFF6-$05D0B0 DATA
;org $0BCFF6
OverworldMap32_Screen45_Low:
{
    incbin "bin/ow/screen45-l.bin" ; size: 0x00BB
}

; $05D0B1-$05D168 DATA
;org $0BD0B1
OverworldMap32_Screen46_High:
{
    incbin "bin/ow/screen46-h.bin" ; size: 0x00B8
}

; $05D169-$05D243 DATA
;org $0BD169
OverworldMap32_Screen46_Low:
{
    incbin "bin/ow/screen46-l.bin" ; size: 0x00DB
}

; $05D244-$05D30A DATA
;org $0BD244
OverworldMap32_Screen47_High:
{
    incbin "bin/ow/screen47-h.bin" ; size: 0x00C7
}

; $05D30B-$05D3F5 DATA
;org $0BD30B
OverworldMap32_Screen47_Low:
{
    incbin "bin/ow/screen47-l.bin" ; size: 0x00EB
}

; $05D3F6-$05D4A3 DATA
;org $0BD3F6
OverworldMap32_Screen48_High:
{
    incbin "bin/ow/screen48-h.bin" ; size: 0x00AE
}

; $05D4A4-$05D587 DATA
;org $0BD4A4
OverworldMap32_Screen48_Low:
{
    incbin "bin/ow/screen48-l.bin" ; size: 0x00E4
}

; $05D588-$05D61B DATA
;org $0BD588
OverworldMap32_Screen49_High:
{
    incbin "bin/ow/screen49-h.bin" ; size: 0x0094
}

; $05D61C-$05D708 DATA
;org $0BD61C
OverworldMap32_Screen49_Low:
{
    incbin "bin/ow/screen49-l.bin" ; size: 0x00ED
}

; $05D709-$05D7EF DATA
;org $0BD709
OverworldMap32_Screen0A_High:
{
    incbin "bin/ow/screen0A-h.bin" ; size: 0x00E7
}

; $05D7F0-$05D8E8 DATA
;org $0BD7F0
OverworldMap32_Screen0A_Low:
{
    incbin "bin/ow/screen0A-l.bin" ; size: 0x00F9
}

; $05D8E9-$05D9BE DATA
;org $0BD8E9
OverworldMap32_Screen4B_High:
{
    incbin "bin/ow/screen4B-h.bin" ; size: 0x00D6
}

; $05D9BF-$05DAA6 DATA
;org $0BD9BF
OverworldMap32_Screen4B_Low:
{
    incbin "bin/ow/screen4B-l.bin" ; size: 0x00E8
}

; $05DAA7-$05DB5F DATA
;org $0BDAA7
OverworldMap32_Screen4C_High:
{
    incbin "bin/ow/screen4C-h.bin" ; size: 0x00B9
}

; $05DB60-$05DC4C DATA
;org $0BDB60
OverworldMap32_Screen4C_Low:
{
    incbin "bin/ow/screen4C-l.bin" ; size: 0x00ED
}

; $05DC4D-$05DD29 DATA
;org $0BDC4D
OverworldMap32_Screen4D_High:
{
    incbin "bin/ow/screen4D-h.bin" ; size: 0x00DD
}

; $05DD2A-$05DE22 DATA
;org $0BDD2A
OverworldMap32_Screen4D_Low:
{
    incbin "bin/ow/screen4D-l.bin" ; size: 0x00F9
}

; $05DE23-$05DF12 DATA
;org $0BDE23
OverworldMap32_Screen4E_High:
{
    incbin "bin/ow/screen4E-h.bin" ; size: 0x00F0
}

; $05DF13-$05E010 DATA
;org $0BDF13
OverworldMap32_Screen4E_Low:
{
    incbin "bin/ow/screen4E-l.bin" ; size: 0x00FE
}

; $05E011-$05E0EFDATA
;org $0BE011
OverworldMap32_Screen4F_High:
{
    incbin "bin/ow/screen4F-h.bin" ; size: 0x00DF
}

; $05E0F0-$05E1DD DATA
;org $0BE0F0
OverworldMap32_Screen4F_Low:
{
    incbin "bin/ow/screen4F-l.bin" ; size: 0x00EE
}

; $05E1DE-$05E2A2 DATA
;org $0BE1DE
OverworldMap32_Screen50_High:
{
    incbin "bin/ow/screen50-h.bin" ; size: 0x00C5
}

; $05E2A3-$05E399 DATA
;org $0BE2A3
OverworldMap32_Screen50_Low:
{
    incbin "bin/ow/screen50-l.bin" ; size: 0x00F7
}

; $05E39A-$05E467 DATA
;org $0BE39A
OverworldMap32_Screen11_High:
{
    incbin "bin/ow/screen11-h.bin" ; size: 0x00CE
}

; $05E468-$05E556 DATA
;org $0BE468
OverworldMap32_Screen11_Low:
{
    incbin "bin/ow/screen11-l.bin" ; size: 0x00EF
}

; $05E557-$05E649 DATA
;org $0BE557
OverworldMap32_Screen12_High:
{
    incbin "bin/ow/screen12-h.bin" ; size: 0x00F3
}

; $05E64A-$05E74A DATA
;org $0BE64A
OverworldMap32_Screen12_Low:
{
    incbin "bin/ow/screen12-l.bin" ; size: 0x0101
}

; $05E74B-$05E806 DATA
;org $0BE74B
OverworldMap32_Screen53_High:
{
    incbin "bin/ow/screen53-h.bin" ; size: 0x00BC
}

; $05E807-$05E8DE DATA
;org $0BE807
OverworldMap32_Screen53_Low:
{
    incbin "bin/ow/screen53-l.bin" ; size: 0x00D8
}

; $05E8DF-$05E975 DATA
;org $0BE8DF
OverworldMap32_Screen54_High:
{
    incbin "bin/ow/screen54-h.bin" ; size: 0x0097
}

; $05E976-$05EA36 DATA
;org $0BE976
OverworldMap32_Screen54_Low:
{
    incbin "bin/ow/screen54-l.bin" ; size: 0x00C1
}

; $05EA37-$05EB0E DATA
;org $0BEA37
OverworldMap32_Screen55_High:
{
    incbin "bin/ow/screen55-h.bin" ; size: 0x00D8
}

; $05EB0F-$05EC00 DATA
;org $0BEB0F
OverworldMap32_Screen55_Low:
{
    incbin "bin/ow/screen55-l.bin" ; size: 0x00F2
}

; $05EC01-$05ECCA DATA
;org $0BEC01
OverworldMap32_Screen56_High:
{
    incbin "bin/ow/screen56-h.bin" ; size: 0x00CA
}

; $05ECCB-$05EDC1 DATA
;org $0BECCB
OverworldMap32_Screen56_Low:
{
    incbin "bin/ow/screen56-l.bin" ; size: 0x00F7
}

; $05EDC2-$05EEA6 DATA
;org $0BEDC2
OverworldMap32_Screen17_High:
{
    incbin "bin/ow/screen17-h.bin" ; size: 0x00E5
}

; $05EEA7-$05EF99 DATA
;org $0BEEA7
OverworldMap32_Screen17_Low:
{
    incbin "bin/ow/screen17-l.bin" ; size: 0x00F3
}

; $05EF9A-$05F066 DATA
;org $0BEF9A
OverworldMap32_Screen58_High:
{
    incbin "bin/ow/screen58-h.bin" ; size: 0x00CD
}

; $05F067-$05F155 DATA
;org $0BF067
OverworldMap32_Screen58_Low:
{
    incbin "bin/ow/screen58-l.bin" ; size: 0x00EF
}

; $05F156-$05F212 DATA
;org $0BF156
OverworldMap32_Screen59_High:
{
    incbin "bin/ow/screen59-h.bin" ; size: 0x00BD
}

; $05F213-$05F2F3 DATA
;org $0BF213
OverworldMap32_Screen59_Low:
{
    incbin "bin/ow/screen59-l.bin" ; size: 0x00E1
}

; $05F2F4-$05F3E2 DATA
;org $0BF2F4
OverworldMap32_Screen5A_High:
{
    incbin "bin/ow/screen5A-h.bin" ; size: 0x00EF
}

; $05F3E3-$05F4E3 DATA
;org $0BF3E3
OverworldMap32_Screen5A_Low:
{
    incbin "bin/ow/screen5A-l.bin" ; size: 0x0101
}

; $05F4E4-$05F51E DATA
;org $0BF4E4
OverworldMap32_Screen5B_High:
{
    incbin "bin/ow/screen5B-h.bin" ; size: 0x003B
}

; $05F51F-$05F5BA DATA
;org $0BF51F
OverworldMap32_Screen5B_Low:
{
    incbin "bin/ow/screen5B-l.bin" ; size: 0x009C
}

; $05F5BB-$05F611 DATA
;org $0BF5BB
OverworldMap32_Screen5C_High:
{
    incbin "bin/ow/screen5C-h.bin" ; size: 0x0057
}

; $05F612-$05F6B2 DATA
;org $0BF612
OverworldMap32_Screen5C_Low:
{
    incbin "bin/ow/screen5C-l.bin" ; size: 0x00A1
}

; $05F6B3-$05F7A3 DATA
;org $0BF6B3
OverworldMap32_Screen5D_High:
{
    incbin "bin/ow/screen5D-h.bin" ; size: 0x00F1
}

; $05F7A4-$05F8A3 DATA
;org $0BF7A4
OverworldMap32_Screen5D_Low:
{
    incbin "bin/ow/screen5D-l.bin" ; size: 0x0100
}

; $05F8A4-$05F8DD DATA
;org $0BF8A4
OverworldMap32_Screen5E_High:
{
    incbin "bin/ow/screen5E-h.bin" ; size: 0x003A
}

; $05F8DE-$05F9A9 DATA
;org $0BF8DE
OverworldMap32_Screen5E_Low:
{
    incbin "bin/ow/screen5E-l.bin" ; size: 0x00CC
}

; $05F9AA-$05FA3E DATA
;org $0BF9AA
OverworldMap32_Screen5F_High:
{
    incbin "bin/ow/screen5F-h.bin" ; size: 0x0095
}

; $05FA3F-$05FB14 DATA
;org $0BFA3F
OverworldMap32_Screen5F_Low:
{
    incbin "bin/ow/screen5F-l.bin" ; size: 0x00D6
}

; $05FB15-$05FBD4 DATA
;org $0BFB15
OverworldMap32_Screen60_High:
{
    incbin "bin/ow/screen60-h.bin" ; size: 0x00C0
}

; $05FBD5-$05FCB8 DATA
;org $0BFBD5
OverworldMap32_Screen60_Low:
{
    incbin "bin/ow/screen60-l.bin" ; size: 0x00E4
}

; $05FCB9-$05FD6C DATA
;org $0BFCB9
OverworldMap32_Screen61_High:
{
    incbin "bin/ow/screen61-h.bin" ; size: 0x00B4
}

; $05FD6D-$05FE5E DATA
;org $0BFD6D
OverworldMap32_Screen61_Low:
{
    incbin "bin/ow/screen61-l.bin" ; size: 0x00F1
}

; ==============================================================================

; TODO: Find the missing data here.

; ==============================================================================

; $05FE70-$05FFA7 LONG JUMP LOCATION
; ZS replaces the latter half of this function.
Overworld_SetFixedColorAndScroll:
{
    ; Turn the subscreen off for the moment.
    STZ.b $1D
        
    REP #$30
        
    LDX.w #$19C6
        LDA.b $8A : CMP.w #$0080 : BNE .notMasterSwordArea
        
        LDA.b $A0 : CMP.w #$0181 : BNE .setBgColor
            INC.b $1D
        
            BRA .useDefaultGreen
    
        .notMasterSwordArea
    
        ; If area == 0x81 branch
        CMP.w #$0081 : BEQ .setBgColor
            LDX.w #$0000
            
            CMP.w #$005B                : BEQ .setBgColor
            AND.w #$00BF : CMP.w #$0003 : BEQ .setBgColor
            CMP.w #$0005                : BEQ .setBgColor
            CMP.w #$0007                : BEQ .setBgColor
    
        .useDefaultGreen
    
        LDX.w #$2669
        
        LDA.b $8A : AND.w #$0040 : BEQ .setBgColor
        
        ; Default tan color for the dark world.
        LDX.w #$2A32
    
    .setBgColor
    
    TXA
    STA.l $7EC500 : STA.l $7EC300 ; Old ZS function call written here.
    STA.l $7EC540 : STA.l $7EC340
    
    ; ZS starts replacing from here.
    ; $05FEC6 - ZS Custom Overworld
    ; Set fixed color to neutral.
    LDA.w #$4020 : STA.b $9C
    LDA.w #$8040 : STA.b $9D
        
    LDA.b $8A : BEQ .noCustomFixedColor
        CMP.w #$0070 : BNE .notSwampOfEvil
            JMP .subscreenOnAndReturn
        
        .notSwampOfEvil
        
        CMP.w #$0040 : BEQ .noCustomFixedColor
        CMP.w #$005B : BEQ .noCustomFixedColor
            LDX.w #$4C26
            LDY.w #$8C4C
            
            CMP.w #$0003 : BEQ .setCustomFixedColor
            CMP.w #$0005 : BEQ .setCustomFixedColor
            CMP.w #$0007 : BEQ .setCustomFixedColor
            
            LDX.w #$4A26
            LDY.w #$874A
            
            CMP.w #$0043 : BEQ .setCustomFixedColor
            CMP.w #$0045 : BEQ .setCustomFixedColor
            
            SEP #$30
            
            ; Update CGRAM this frame.
            INC.b $15
            
            RTL
        
        .setCustomFixedColor
        
        STX.b $9C
        STY.b $9D ; Set the fixed color addition color values.
    
    .noCustomFixedColor
    
    LDA.b $11 : AND.w #$00FF : CMP.w #$0004 : BEQ .BRANCH_11
        ; Make sure BG2 and BG1 Y scroll values are synchronized.
        ; Same for X scroll.
        LDA.b $E8 : STA.b $E6
        LDA.b $E2 : STA.b $E0
            
        LDA.b $8A : AND.w #$003F
            
        ; Are we at Hyrule Castle or Pyramid of Power?
        CMP.w #$001B : BNE .subscreenOnAndReturn
            LDA.b $E2 : SEC : SBC.w #$0778 : LSR A : TAY : AND.w #$4000 : BEQ .BRANCH_7
                TYA : ORA.w #$8000 : TAY
            
            .BRANCH_7
            
            STY.b $00
                
            LDA.b $E2 : SEC : SBC.b $00 : STA.b $E0
                
            LDA.b $E6 : CMP.w #$06C0 : BCC .BRANCH_9
                SEC : SBC.w #$0600 : AND.w #$03FF : CMP.w #$0180 : BCS .BRANCH_8
                    LSR A : ORA.w #$0600
                
                    BRA .BRANCH_10
            
                .BRANCH_8
            
                LDA.w #$06C0
                
                BRA .BRANCH_10
            
            .BRANCH_9

            LDA.b $E6 : AND.w #$00FF : LSR A : ORA.w #$0600
            
            .BRANCH_10
            
            ; Set BG1 vertical scroll.
            STA.b $E6
                
            BRA .subscreenOnAndReturn
    
    .BRANCH_11
    
    LDA.b $8A : AND.w #$003F : CMP.w #$001B : BNE .subscreenOnAndReturn
        ; Synchronize Y scrolls on BG0 and BG1. Same for X scrolls.
        LDA.b $E8 : STA.b $E6
        LDA.b $E2 : STA.b $E0
            
        LDA.w $0410 : AND.w #$00FF : CMP.w #$0008 : BEQ .BRANCH_12
            ; Handles scroll for special areas maybe?
            LDA.w #$0838 : STA.b $E0
        
        .BRANCH_12
        
        LDA.w #$06C0 : STA.b $E6
    
    .subscreenOnAndReturn
    
    SEP #$20
        
    ; Put BG0 on the subscreen.
    LDA.b #$01 : STA.b $1D
        
    SEP #$30
        
    ; Update palette.
    INC.b $15
        
    RTL
}

; ==============================================================================

; $05FFA8-$05FFBE LONG JUMP LOCATION
WallMaster_SendPlayerToLastEntrance:
{
    JSL Dungeon_SaveRoomData.justKeys
    JSL Dungeon_SaveRoomQuadrantData
    JSL Sprite_ResetAll
    
    ; Don't use a starting point entrance.
    STZ.w $04AA
    
    ; Falling into an overworld hole mode.
    LDA.b #$11 : STA.b $10
    
    STZ.b $11
    STZ.b $14

    ; Bleeds into the next function.
}

; $05FFBF-$05FFED LONG JUMP LOCATION
ResetSomeThingsAfterDeath:
{
    STZ.w $0345
    
    ; TODO: Investigate this:
    ; \wtf 0x11? Written here? I thought these were all even.
    STA.w $005E
    
    STZ.w $03F3
    STZ.w $0322
    STZ.w $02E4
    STZ.w $0ABD
    STZ.w $036B
    STZ.w $0373
    
    STZ.b $27
    STZ.b $28
    
    STZ.b $29
    
    STZ.b $24
    
    STZ.w $0351
    STZ.w $0316
    STZ.w $031F
    
    LDA.b #$00 : STA.b $5D
    
    STZ.b $4B
}

; $05FFEE-$05FFF5 LONG JUMP LOCATION
ResetAncillaAndLink:
{
    JSL Ancilla_TerminateSelectInteractives
    JML Player_ResetState
}

; ==============================================================================

warnpc $0C8000