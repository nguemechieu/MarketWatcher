<chart>
id=132937608772631527
symbol=GBPUSD
period=30
leftpos=987
digits=5
scale=4
graph=0
fore=0
grid=1
volume=0
scroll=1
shift=0
ohlc=1
one_click=0
one_click_btn=0
askline=0
days=0
descriptions=0
shift_size=20
fixed_pos=0
window_left=307
window_top=0
window_right=614
window_bottom=159
window_type=1
background_color=0
foreground_color=16777215
barup_color=65280
bardown_color=65280
bullcandle_color=0
bearcandle_color=16777215
chartline_color=65280
volumes_color=3329330
grid_color=10061943
askline_color=255
stops_color=255

<window>
height=100
fixed_height=0
<indicator>
name=main
<object>
type=23
object_name=RPTBalance
period_flags=0
create_time=1649640105
description=Balance: 76.01 USD
color=2402047
font=Arial
fontsize=8
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=20
y_distance=25
</object>
<object>
type=23
object_name=RPTAllSymbolPercentRisked
period_flags=0
create_time=1649640105
description=All GBPUSD's % Risked : 0.00%
color=2402047
font=Arial
fontsize=8
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=20
y_distance=45
</object>
<object>
type=23
object_name=RPTAllSymbolPercentTarget
period_flags=0
create_time=1649640105
description=All GBPUSD's % Target : 0.00%
color=2402047
font=Arial
fontsize=8
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=20
y_distance=65
</object>
<object>
type=2
object_name=Support
period_flags=0
create_time=1649640105
color=16711680
style=0
weight=2
background=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1649660400
value_0=1.300780
time_1=1649640600
value_1=1.300780
ray=0
</object>
<object>
type=23
object_name=TrendExpertInd_1L_Title
period_flags=0
create_time=1649640599
description=TradeExpert Signal
color=14480885
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=3
y_distance=75
</object>
<object>
type=23
object_name=TrendExpertInd_1L_Trade
period_flags=0
create_time=1649640599
description=Trade: Sell
color=14480885
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=3
y_distance=120
</object>
<object>
type=23
object_name=TrendExpertInd_1L_StartP
period_flags=0
create_time=1649640599
description=Entry price: 1.3023
color=14480885
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=3
y_distance=140
</object>
<object>
type=23
object_name=TrendExpertInd_1L_SL
period_flags=0
create_time=1649640599
description=Current SL: 1.3031
color=14480885
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=3
y_distance=160
</object>
<object>
type=23
object_name=TrendExpertInd_1L_Spread
period_flags=0
create_time=1649640599
description=Current spread: 1.9
color=14480885
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=3
y_distance=180
</object>
<object>
type=23
object_name=TrendExpertInd_1L_Lots
period_flags=0
create_time=1649640599
description=2.0 % risk per SL in lots: 0.0
color=14480885
font=Arial
fontsize=10
angle=0
anchor_pos=0
background=0
filling=0
selectable=1
hidden=0
zorder=0
corner=0
x_distance=3
y_distance=200
</object>
</indicator>
<indicator>
name=Moving Average
period=14
shift=0
method=0
apply=0
color=255
style=0
weight=1
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TrendsFollowers
flags=339
window_num=0
<inputs>
chatId=805814430
InpToken=
InpChannelName=
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=5897984
style_0=0
weight_0=4
arrow_0=241
shift_1=0
draw_1=3
color_1=7536895
style_1=0
weight_1=4
arrow_1=242
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=TrendExpert
flags=339
window_num=0
<inputs>
MAFastBars=10
MAFastType=1
MAFastPrice=6
MASlowBars=30
MASlowType=2
MASlowPrice=6
ChandBars=7
ChandATRFact=2.0
RiskPercent=2.0
Offset=10
BarsBack=2000
InfoColor=16448255
AlertSound=alert.wav
UseSoundAlert=true
UsePopupAlert=true
WriteToLog=false
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=15453831
style_0=0
weight_0=3
arrow_0=233
shift_1=0
draw_1=3
color_1=17919
style_1=0
weight_1=3
arrow_1=234
shift_2=0
draw_2=3
color_2=15453831
style_2=0
weight_2=3
arrow_2=251
shift_3=0
draw_3=3
color_3=17919
style_3=0
weight_3=3
arrow_3=251
shift_4=0
draw_4=0
color_4=55295
style_4=1
weight_4=1
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=THE_ATM_INDICATOR_FX_master
flags=339
window_num=0
<inputs>
cRPTFontClr=2402047
Period1=3
Period2=34
SR_LIMIT_BARS=0
Audible_Alerts=true
Push_Notifications=true
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=16777215
style_0=0
weight_0=4
arrow_0=233
shift_1=0
draw_1=3
color_1=16777215
style_1=0
weight_1=4
arrow_1=234
shift_2=0
draw_2=3
color_2=16777215
style_2=0
weight_2=1
arrow_2=233
shift_3=0
draw_3=3
color_3=16777215
style_3=0
weight_3=1
arrow_3=234
shift_4=0
draw_4=0
color_4=2818303
style_4=0
weight_4=2
shift_5=0
draw_5=0
color_5=16744448
style_5=0
weight_5=2
shift_6=0
draw_6=12
color_6=16755200
style_6=0
weight_6=1
shift_7=0
draw_7=12
color_7=16755200
style_7=0
weight_7=1
shift_8=0
draw_8=2
color_8=65280
style_8=0
weight_8=3
shift_9=0
draw_9=2
color_9=65280
style_9=0
weight_9=3
shift_10=0
draw_10=2
color_10=65280
style_10=0
weight_10=1
shift_11=0
draw_11=2
color_11=65280
style_11=0
weight_11=1
shift_12=0
draw_12=2
color_12=32768
style_12=0
weight_12=3
shift_13=0
draw_13=2
color_13=32768
style_13=0
weight_13=3
shift_14=0
draw_14=0
color_14=4294967295
style_14=0
weight_14=0
shift_15=0
draw_15=2
color_15=32768
style_15=0
weight_15=1
shift_16=0
draw_16=0
color_16=32768
style_16=0
weight_16=1
shift_17=0
draw_17=2
color_17=4678655
style_17=0
weight_17=3
shift_18=0
draw_18=2
color_18=4678655
style_18=0
weight_18=3
shift_19=0
draw_19=2
color_19=4678655
style_19=0
weight_19=1
shift_20=0
draw_20=2
color_20=4678655
style_20=0
weight_20=1
shift_21=0
draw_21=2
color_21=255
style_21=0
weight_21=3
shift_22=0
draw_22=2
color_22=255
style_22=0
weight_22=3
shift_23=0
draw_23=2
color_23=255
style_23=0
weight_23=1
shift_24=0
draw_24=2
color_24=255
style_24=0
weight_24=1
shift_25=0
draw_25=0
color_25=0
style_25=0
weight_25=0
shift_26=0
draw_26=0
color_26=0
style_26=0
weight_26=0
shift_27=0
draw_27=0
color_27=0
style_27=0
weight_27=0
shift_28=0
draw_28=0
color_28=0
style_28=0
weight_28=0
shift_29=0
draw_29=0
color_29=0
style_29=0
weight_29=0
shift_30=0
draw_30=0
color_30=0
style_30=0
weight_30=0
shift_31=0
draw_31=0
color_31=0
style_31=0
weight_31=0
shift_32=0
draw_32=0
color_32=0
style_32=0
weight_32=0
shift_33=0
draw_33=0
color_33=0
style_33=0
weight_33=0
shift_34=0
draw_34=0
color_34=0
style_34=0
weight_34=0
shift_35=0
draw_35=0
color_35=0
style_35=0
weight_35=0
shift_36=0
draw_36=0
color_36=0
style_36=0
weight_36=0
shift_37=0
draw_37=0
color_37=0
style_37=0
weight_37=0
shift_38=0
draw_38=0
color_38=0
style_38=0
weight_38=0
shift_39=0
draw_39=0
color_39=0
style_39=0
weight_39=0
shift_40=0
draw_40=0
color_40=0
style_40=0
weight_40=0
shift_41=0
draw_41=0
color_41=0
style_41=0
weight_41=0
shift_42=0
draw_42=0
color_42=0
style_42=0
weight_42=0
shift_43=0
draw_43=0
color_43=0
style_43=0
weight_43=0
shift_44=0
draw_44=0
color_44=0
style_44=0
weight_44=0
shift_45=0
draw_45=0
color_45=0
style_45=0
weight_45=0
shift_46=0
draw_46=0
color_46=0
style_46=0
weight_46=0
shift_47=0
draw_47=0
color_47=0
style_47=0
weight_47=0
shift_48=0
draw_48=0
color_48=0
style_48=0
weight_48=0
shift_49=0
draw_49=0
color_49=0
style_49=0
weight_49=0
shift_50=0
draw_50=0
color_50=0
style_50=0
weight_50=0
shift_51=0
draw_51=0
color_51=0
style_51=0
weight_51=0
shift_52=0
draw_52=0
color_52=0
style_52=0
weight_52=0
shift_53=0
draw_53=0
color_53=0
style_53=0
weight_53=0
shift_54=0
draw_54=0
color_54=0
style_54=0
weight_54=0
shift_55=0
draw_55=0
color_55=0
style_55=0
weight_55=0
shift_56=0
draw_56=0
color_56=0
style_56=0
weight_56=0
shift_57=0
draw_57=0
color_57=0
style_57=0
weight_57=0
shift_58=0
draw_58=0
color_58=0
style_58=0
weight_58=0
shift_59=0
draw_59=0
color_59=0
style_59=0
weight_59=0
shift_60=0
draw_60=0
color_60=0
style_60=0
weight_60=0
shift_61=0
draw_61=0
color_61=0
style_61=0
weight_61=0
shift_62=0
draw_62=0
color_62=0
style_62=0
weight_62=0
shift_63=0
draw_63=0
color_63=0
style_63=0
weight_63=0
shift_64=0
draw_64=0
color_64=0
style_64=0
weight_64=0
shift_65=0
draw_65=0
color_65=0
style_65=0
weight_65=0
shift_66=0
draw_66=0
color_66=0
style_66=0
weight_66=0
shift_67=0
draw_67=0
color_67=0
style_67=0
weight_67=0
shift_68=0
draw_68=0
color_68=0
style_68=0
weight_68=0
shift_69=0
draw_69=0
color_69=0
style_69=0
weight_69=0
shift_70=0
draw_70=0
color_70=0
style_70=0
weight_70=0
shift_71=0
draw_71=0
color_71=0
style_71=0
weight_71=0
shift_72=0
draw_72=0
color_72=0
style_72=0
weight_72=0
shift_73=0
draw_73=0
color_73=0
style_73=0
weight_73=0
shift_74=0
draw_74=0
color_74=0
style_74=0
weight_74=0
shift_75=0
draw_75=0
color_75=0
style_75=0
weight_75=0
shift_76=0
draw_76=0
color_76=0
style_76=0
weight_76=0
shift_77=0
draw_77=0
color_77=0
style_77=0
weight_77=0
shift_78=0
draw_78=0
color_78=0
style_78=0
weight_78=0
shift_79=0
draw_79=0
color_79=0
style_79=0
weight_79=0
shift_80=0
draw_80=0
color_80=0
style_80=0
weight_80=0
shift_81=0
draw_81=0
color_81=0
style_81=0
weight_81=0
shift_82=0
draw_82=0
color_82=0
style_82=0
weight_82=0
shift_83=0
draw_83=0
color_83=0
style_83=0
weight_83=0
shift_84=0
draw_84=0
color_84=0
style_84=0
weight_84=0
shift_85=0
draw_85=0
color_85=0
style_85=0
weight_85=0
shift_86=0
draw_86=0
color_86=0
style_86=0
weight_86=0
shift_87=0
draw_87=0
color_87=0
style_87=0
weight_87=0
shift_88=0
draw_88=0
color_88=0
style_88=0
weight_88=0
shift_89=0
draw_89=0
color_89=0
style_89=0
weight_89=0
shift_90=0
draw_90=0
color_90=0
style_90=0
weight_90=0
shift_91=0
draw_91=0
color_91=0
style_91=0
weight_91=0
shift_92=0
draw_92=0
color_92=0
style_92=0
weight_92=0
shift_93=0
draw_93=0
color_93=0
style_93=0
weight_93=0
shift_94=0
draw_94=0
color_94=0
style_94=0
weight_94=0
shift_95=0
draw_95=0
color_95=0
style_95=0
weight_95=0
shift_96=0
draw_96=0
color_96=0
style_96=0
weight_96=0
shift_97=0
draw_97=0
color_97=0
style_97=0
weight_97=0
shift_98=0
draw_98=0
color_98=0
style_98=0
weight_98=0
shift_99=0
draw_99=0
color_99=0
style_99=0
weight_99=0
shift_100=0
draw_100=0
color_100=0
style_100=0
weight_100=0
shift_101=0
draw_101=0
color_101=0
style_101=0
weight_101=0
shift_102=0
draw_102=0
color_102=0
style_102=0
weight_102=0
shift_103=0
draw_103=0
color_103=0
style_103=0
weight_103=0
shift_104=0
draw_104=0
color_104=0
style_104=0
weight_104=0
shift_105=0
draw_105=0
color_105=0
style_105=0
weight_105=0
shift_106=0
draw_106=0
color_106=0
style_106=0
weight_106=0
shift_107=0
draw_107=0
color_107=0
style_107=0
weight_107=0
shift_108=0
draw_108=0
color_108=0
style_108=0
weight_108=0
shift_109=0
draw_109=0
color_109=0
style_109=0
weight_109=0
shift_110=0
draw_110=0
color_110=0
style_110=0
weight_110=0
shift_111=0
draw_111=0
color_111=0
style_111=0
weight_111=0
shift_112=0
draw_112=0
color_112=0
style_112=0
weight_112=0
shift_113=0
draw_113=0
color_113=0
style_113=0
weight_113=0
shift_114=0
draw_114=0
color_114=0
style_114=0
weight_114=0
shift_115=0
draw_115=0
color_115=0
style_115=0
weight_115=0
shift_116=0
draw_116=0
color_116=0
style_116=0
weight_116=0
shift_117=0
draw_117=0
color_117=0
style_117=0
weight_117=0
shift_118=0
draw_118=0
color_118=0
style_118=0
weight_118=0
shift_119=0
draw_119=0
color_119=0
style_119=0
weight_119=0
shift_120=0
draw_120=0
color_120=0
style_120=0
weight_120=0
shift_121=0
draw_121=0
color_121=0
style_121=0
weight_121=0
shift_122=0
draw_122=0
color_122=0
style_122=0
weight_122=0
shift_123=0
draw_123=0
color_123=0
style_123=0
weight_123=0
shift_124=0
draw_124=0
color_124=0
style_124=0
weight_124=0
shift_125=0
draw_125=0
color_125=0
style_125=0
weight_125=0
shift_126=0
draw_126=0
color_126=0
style_126=0
weight_126=0
shift_127=0
draw_127=0
color_127=0
style_127=0
weight_127=0
shift_128=0
draw_128=0
color_128=0
style_128=0
weight_128=0
shift_129=0
draw_129=0
color_129=0
style_129=0
weight_129=0
shift_130=0
draw_130=0
color_130=0
style_130=0
weight_130=0
shift_131=0
draw_131=0
color_131=0
style_131=0
weight_131=0
shift_132=0
draw_132=0
color_132=0
style_132=0
weight_132=0
shift_133=0
draw_133=0
color_133=0
style_133=0
weight_133=0
shift_134=0
draw_134=0
color_134=0
style_134=0
weight_134=0
shift_135=0
draw_135=0
color_135=0
style_135=0
weight_135=0
shift_136=0
draw_136=0
color_136=0
style_136=0
weight_136=0
shift_137=0
draw_137=0
color_137=0
style_137=0
weight_137=0
shift_138=0
draw_138=0
color_138=0
style_138=0
weight_138=0
shift_139=0
draw_139=0
color_139=0
style_139=0
weight_139=0
shift_140=0
draw_140=0
color_140=0
style_140=0
weight_140=0
shift_141=0
draw_141=0
color_141=0
style_141=0
weight_141=0
shift_142=0
draw_142=0
color_142=0
style_142=0
weight_142=0
shift_143=0
draw_143=0
color_143=0
style_143=0
weight_143=0
shift_144=0
draw_144=0
color_144=0
style_144=0
weight_144=0
shift_145=0
draw_145=0
color_145=0
style_145=0
weight_145=0
shift_146=0
draw_146=0
color_146=0
style_146=0
weight_146=0
shift_147=0
draw_147=0
color_147=0
style_147=0
weight_147=0
shift_148=0
draw_148=0
color_148=0
style_148=0
weight_148=0
shift_149=0
draw_149=0
color_149=0
style_149=0
weight_149=0
shift_150=0
draw_150=0
color_150=0
style_150=0
weight_150=0
shift_151=0
draw_151=0
color_151=0
style_151=0
weight_151=0
shift_152=0
draw_152=0
color_152=0
style_152=0
weight_152=0
shift_153=0
draw_153=0
color_153=0
style_153=0
weight_153=0
shift_154=0
draw_154=0
color_154=0
style_154=0
weight_154=0
shift_155=0
draw_155=0
color_155=0
style_155=0
weight_155=0
shift_156=0
draw_156=0
color_156=0
style_156=0
weight_156=0
shift_157=0
draw_157=0
color_157=0
style_157=0
weight_157=0
shift_158=0
draw_158=0
color_158=0
style_158=0
weight_158=0
shift_159=0
draw_159=0
color_159=0
style_159=0
weight_159=0
shift_160=0
draw_160=0
color_160=0
style_160=0
weight_160=0
shift_161=0
draw_161=0
color_161=0
style_161=0
weight_161=0
shift_162=0
draw_162=0
color_162=0
style_162=0
weight_162=0
shift_163=0
draw_163=0
color_163=0
style_163=0
weight_163=0
shift_164=0
draw_164=0
color_164=0
style_164=0
weight_164=0
shift_165=0
draw_165=0
color_165=0
style_165=0
weight_165=0
shift_166=0
draw_166=0
color_166=0
style_166=0
weight_166=0
shift_167=0
draw_167=0
color_167=0
style_167=0
weight_167=0
shift_168=0
draw_168=0
color_168=0
style_168=0
weight_168=0
shift_169=0
draw_169=0
color_169=0
style_169=0
weight_169=0
shift_170=0
draw_170=2
color_170=0
style_170=0
weight_170=0
period_flags=0
show_data=1
</indicator>
</window>
</chart>
