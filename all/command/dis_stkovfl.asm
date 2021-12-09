
stkovfl:     file format elf32-i386


Disassembly of section .text:

00001000 <read_func>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 18             	sub    $0x18,%esp
    1006:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    100d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1014:	83 ec 0c             	sub    $0xc,%esp
    1017:	68 b8 18 00 00       	push   $0x18b8
    101c:	e8 6d 01 00 00       	call   118e <printf>
    1021:	83 c4 10             	add    $0x10,%esp
    1024:	83 ec 08             	sub    $0x8,%esp
    1027:	ff 75 08             	pushl  0x8(%ebp)
    102a:	8d 45 f0             	lea    -0x10(%ebp),%eax
    102d:	50                   	push   %eax
    102e:	e8 57 05 00 00       	call   158a <strcpy>
    1033:	83 c4 10             	add    $0x10,%esp
    1036:	83 ec 08             	sub    $0x8,%esp
    1039:	8d 45 f0             	lea    -0x10(%ebp),%eax
    103c:	50                   	push   %eax
    103d:	68 cc 18 00 00       	push   $0x18cc
    1042:	e8 47 01 00 00       	call   118e <printf>
    1047:	83 c4 10             	add    $0x10,%esp
    104a:	90                   	nop
    104b:	90                   	nop
    104c:	90                   	nop
    104d:	90                   	nop
    104e:	c9                   	leave  
    104f:	c3                   	ret    

00001050 <ovfl_goal>:
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	83 ec 08             	sub    $0x8,%esp
    1056:	83 ec 0c             	sub    $0xc,%esp
    1059:	68 e0 18 00 00       	push   $0x18e0
    105e:	e8 2b 01 00 00       	call   118e <printf>
    1063:	83 c4 10             	add    $0x10,%esp
    1066:	83 ec 0c             	sub    $0xc,%esp
    1069:	68 10 19 00 00       	push   $0x1910
    106e:	e8 1b 01 00 00       	call   118e <printf>
    1073:	83 c4 10             	add    $0x10,%esp
    1076:	90                   	nop
    1077:	c9                   	leave  
    1078:	c3                   	ret    

00001079 <main>:
    1079:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    107d:	83 e4 f0             	and    $0xfffffff0,%esp
    1080:	ff 71 fc             	pushl  -0x4(%ecx)
    1083:	55                   	push   %ebp
    1084:	89 e5                	mov    %esp,%ebp
    1086:	51                   	push   %ecx
    1087:	83 ec 44             	sub    $0x44,%esp
    108a:	89 c8                	mov    %ecx,%eax
    108c:	c7 45 ec 48 65 6c 6c 	movl   $0x6c6c6548,-0x14(%ebp)
    1093:	c7 45 f0 6f 21 00 00 	movl   $0x216f,-0x10(%ebp)
    109a:	c7 45 dc 48 65 6c 6c 	movl   $0x6c6c6548,-0x24(%ebp)
    10a1:	c7 45 e0 6f 21 48 65 	movl   $0x6548216f,-0x20(%ebp)
    10a8:	c7 45 e4 6c 6c 6f 21 	movl   $0x216f6c6c,-0x1c(%ebp)
    10af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    10b6:	c6 45 c4 01          	movb   $0x1,-0x3c(%ebp)
    10ba:	c6 45 c5 01          	movb   $0x1,-0x3b(%ebp)
    10be:	c6 45 c6 01          	movb   $0x1,-0x3a(%ebp)
    10c2:	c6 45 c7 01          	movb   $0x1,-0x39(%ebp)
    10c6:	c6 45 c8 01          	movb   $0x1,-0x38(%ebp)
    10ca:	c6 45 c9 01          	movb   $0x1,-0x37(%ebp)
    10ce:	c6 45 ca 01          	movb   $0x1,-0x36(%ebp)
    10d2:	c6 45 cb 01          	movb   $0x1,-0x35(%ebp)
    10d6:	c6 45 cc 01          	movb   $0x1,-0x34(%ebp)
    10da:	c6 45 cd 01          	movb   $0x1,-0x33(%ebp)
    10de:	c6 45 ce 01          	movb   $0x1,-0x32(%ebp)
    10e2:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
    10e6:	c6 45 d0 01          	movb   $0x1,-0x30(%ebp)
    10ea:	c6 45 d1 01          	movb   $0x1,-0x2f(%ebp)
    10ee:	c6 45 d2 01          	movb   $0x1,-0x2e(%ebp)
    10f2:	c6 45 d3 01          	movb   $0x1,-0x2d(%ebp)
    10f6:	c6 45 d4 01          	movb   $0x1,-0x2c(%ebp)
    10fa:	c6 45 d5 01          	movb   $0x1,-0x2b(%ebp)
    10fe:	c6 45 d6 01          	movb   $0x1,-0x2a(%ebp)
    1102:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
    1106:	c6 45 d8 50          	movb   $0x50,-0x28(%ebp)
    110a:	c6 45 d9 10          	movb   $0x10,-0x27(%ebp)
    110e:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    1112:	c6 45 db 00          	movb   $0x0,-0x25(%ebp)
    1116:	8d 55 ec             	lea    -0x14(%ebp),%edx
    1119:	89 55 b8             	mov    %edx,-0x48(%ebp)
    111c:	8d 55 dc             	lea    -0x24(%ebp),%edx
    111f:	89 55 bc             	mov    %edx,-0x44(%ebp)
    1122:	8d 55 c4             	lea    -0x3c(%ebp),%edx
    1125:	89 55 c0             	mov    %edx,-0x40(%ebp)
    1128:	8b 50 04             	mov    0x4(%eax),%edx
    112b:	83 c2 04             	add    $0x4,%edx
    112e:	8b 12                	mov    (%edx),%edx
    1130:	0f b6 12             	movzbl (%edx),%edx
    1133:	0f be d2             	movsbl %dl,%edx
    1136:	83 ea 30             	sub    $0x30,%edx
    1139:	89 55 f4             	mov    %edx,-0xc(%ebp)
    113c:	83 38 01             	cmpl   $0x1,(%eax)
    113f:	75 07                	jne    1148 <main+0xcf>
    1141:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1148:	83 ec 08             	sub    $0x8,%esp
    114b:	ff 75 f4             	pushl  -0xc(%ebp)
    114e:	68 3d 19 00 00       	push   $0x193d
    1153:	e8 36 00 00 00       	call   118e <printf>
    1158:	83 c4 10             	add    $0x10,%esp
    115b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    115e:	8b 44 85 b8          	mov    -0x48(%ebp,%eax,4),%eax
    1162:	83 ec 0c             	sub    $0xc,%esp
    1165:	50                   	push   %eax
    1166:	e8 95 fe ff ff       	call   1000 <read_func>
    116b:	83 c4 10             	add    $0x10,%esp
    116e:	b8 00 00 00 00       	mov    $0x0,%eax
    1173:	8b 4d fc             	mov    -0x4(%ebp),%ecx
    1176:	c9                   	leave  
    1177:	8d 61 fc             	lea    -0x4(%ecx),%esp
    117a:	c3                   	ret    
    117b:	66 90                	xchg   %ax,%ax
    117d:	66 90                	xchg   %ax,%ax
    117f:	90                   	nop

00001180 <_start>:
    1180:	50                   	push   %eax
    1181:	51                   	push   %ecx
    1182:	e8 f2 fe ff ff       	call   1079 <main>
    1187:	50                   	push   %eax
    1188:	e8 b8 06 00 00       	call   1845 <exit>
    118d:	f4                   	hlt    

0000118e <printf>:
    118e:	55                   	push   %ebp
    118f:	89 e5                	mov    %esp,%ebp
    1191:	81 ec 18 04 00 00    	sub    $0x418,%esp
    1197:	8d 45 0c             	lea    0xc(%ebp),%eax
    119a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    119d:	8b 45 08             	mov    0x8(%ebp),%eax
    11a0:	83 ec 04             	sub    $0x4,%esp
    11a3:	ff 75 f4             	pushl  -0xc(%ebp)
    11a6:	50                   	push   %eax
    11a7:	8d 85 ec fb ff ff    	lea    -0x414(%ebp),%eax
    11ad:	50                   	push   %eax
    11ae:	e8 e6 00 00 00       	call   1299 <vsprintf>
    11b3:	83 c4 10             	add    $0x10,%esp
    11b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    11b9:	83 ec 04             	sub    $0x4,%esp
    11bc:	ff 75 f0             	pushl  -0x10(%ebp)
    11bf:	8d 85 ec fb ff ff    	lea    -0x414(%ebp),%eax
    11c5:	50                   	push   %eax
    11c6:	6a 01                	push   $0x1
    11c8:	e8 41 06 00 00       	call   180e <write>
    11cd:	83 c4 10             	add    $0x10,%esp
    11d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d9:	74 19                	je     11f4 <printf+0x66>
    11db:	6a 50                	push   $0x50
    11dd:	68 4c 19 00 00       	push   $0x194c
    11e2:	68 4c 19 00 00       	push   $0x194c
    11e7:	68 59 19 00 00       	push   $0x1959
    11ec:	e8 e4 05 00 00       	call   17d5 <assertion_failure>
    11f1:	83 c4 10             	add    $0x10,%esp
    11f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11f7:	c9                   	leave  
    11f8:	c3                   	ret    

000011f9 <printl>:
    11f9:	55                   	push   %ebp
    11fa:	89 e5                	mov    %esp,%ebp
    11fc:	81 ec 18 04 00 00    	sub    $0x418,%esp
    1202:	8d 45 0c             	lea    0xc(%ebp),%eax
    1205:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1208:	8b 45 08             	mov    0x8(%ebp),%eax
    120b:	83 ec 04             	sub    $0x4,%esp
    120e:	ff 75 f4             	pushl  -0xc(%ebp)
    1211:	50                   	push   %eax
    1212:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
    1218:	50                   	push   %eax
    1219:	e8 7b 00 00 00       	call   1299 <vsprintf>
    121e:	83 c4 10             	add    $0x10,%esp
    1221:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1224:	83 ec 0c             	sub    $0xc,%esp
    1227:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
    122d:	50                   	push   %eax
    122e:	e8 77 06 00 00       	call   18aa <printx>
    1233:	83 c4 10             	add    $0x10,%esp
    1236:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1239:	c9                   	leave  
    123a:	c3                   	ret    

0000123b <i2a>:
    123b:	55                   	push   %ebp
    123c:	89 e5                	mov    %esp,%ebp
    123e:	83 ec 18             	sub    $0x18,%esp
    1241:	8b 45 08             	mov    0x8(%ebp),%eax
    1244:	99                   	cltd   
    1245:	f7 7d 0c             	idivl  0xc(%ebp)
    1248:	89 55 f4             	mov    %edx,-0xc(%ebp)
    124b:	8b 45 08             	mov    0x8(%ebp),%eax
    124e:	99                   	cltd   
    124f:	f7 7d 0c             	idivl  0xc(%ebp)
    1252:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1255:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1259:	74 14                	je     126f <i2a+0x34>
    125b:	83 ec 04             	sub    $0x4,%esp
    125e:	ff 75 10             	pushl  0x10(%ebp)
    1261:	ff 75 0c             	pushl  0xc(%ebp)
    1264:	ff 75 f0             	pushl  -0x10(%ebp)
    1267:	e8 cf ff ff ff       	call   123b <i2a>
    126c:	83 c4 10             	add    $0x10,%esp
    126f:	8b 45 10             	mov    0x10(%ebp),%eax
    1272:	8b 00                	mov    (%eax),%eax
    1274:	8d 48 01             	lea    0x1(%eax),%ecx
    1277:	8b 55 10             	mov    0x10(%ebp),%edx
    127a:	89 0a                	mov    %ecx,(%edx)
    127c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1280:	7f 08                	jg     128a <i2a+0x4f>
    1282:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1285:	83 c2 30             	add    $0x30,%edx
    1288:	eb 06                	jmp    1290 <i2a+0x55>
    128a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    128d:	83 c2 37             	add    $0x37,%edx
    1290:	88 10                	mov    %dl,(%eax)
    1292:	8b 45 10             	mov    0x10(%ebp),%eax
    1295:	8b 00                	mov    (%eax),%eax
    1297:	c9                   	leave  
    1298:	c3                   	ret    

00001299 <vsprintf>:
    1299:	55                   	push   %ebp
    129a:	89 e5                	mov    %esp,%ebp
    129c:	81 ec 28 04 00 00    	sub    $0x428,%esp
    12a2:	8b 45 10             	mov    0x10(%ebp),%eax
    12a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    12a8:	8b 45 08             	mov    0x8(%ebp),%eax
    12ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12ae:	e9 47 02 00 00       	jmp    14fa <vsprintf+0x261>
    12b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b6:	0f b6 00             	movzbl (%eax),%eax
    12b9:	3c 25                	cmp    $0x25,%al
    12bb:	74 16                	je     12d3 <vsprintf+0x3a>
    12bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12c0:	8d 50 01             	lea    0x1(%eax),%edx
    12c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    12c6:	8b 55 0c             	mov    0xc(%ebp),%edx
    12c9:	0f b6 12             	movzbl (%edx),%edx
    12cc:	88 10                	mov    %dl,(%eax)
    12ce:	e9 23 02 00 00       	jmp    14f6 <vsprintf+0x25d>
    12d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12da:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    12de:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e1:	0f b6 00             	movzbl (%eax),%eax
    12e4:	3c 25                	cmp    $0x25,%al
    12e6:	75 16                	jne    12fe <vsprintf+0x65>
    12e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12eb:	8d 50 01             	lea    0x1(%eax),%edx
    12ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
    12f1:	8b 55 0c             	mov    0xc(%ebp),%edx
    12f4:	0f b6 12             	movzbl (%edx),%edx
    12f7:	88 10                	mov    %dl,(%eax)
    12f9:	e9 f8 01 00 00       	jmp    14f6 <vsprintf+0x25d>
    12fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1301:	0f b6 00             	movzbl (%eax),%eax
    1304:	3c 30                	cmp    $0x30,%al
    1306:	75 0a                	jne    1312 <vsprintf+0x79>
    1308:	c6 45 eb 30          	movb   $0x30,-0x15(%ebp)
    130c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1310:	eb 28                	jmp    133a <vsprintf+0xa1>
    1312:	c6 45 eb 20          	movb   $0x20,-0x15(%ebp)
    1316:	eb 22                	jmp    133a <vsprintf+0xa1>
    1318:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    131b:	89 d0                	mov    %edx,%eax
    131d:	c1 e0 02             	shl    $0x2,%eax
    1320:	01 d0                	add    %edx,%eax
    1322:	01 c0                	add    %eax,%eax
    1324:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1327:	8b 45 0c             	mov    0xc(%ebp),%eax
    132a:	0f b6 00             	movzbl (%eax),%eax
    132d:	0f be c0             	movsbl %al,%eax
    1330:	83 e8 30             	sub    $0x30,%eax
    1333:	01 45 e4             	add    %eax,-0x1c(%ebp)
    1336:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    133a:	8b 45 0c             	mov    0xc(%ebp),%eax
    133d:	0f b6 00             	movzbl (%eax),%eax
    1340:	3c 2f                	cmp    $0x2f,%al
    1342:	76 0a                	jbe    134e <vsprintf+0xb5>
    1344:	8b 45 0c             	mov    0xc(%ebp),%eax
    1347:	0f b6 00             	movzbl (%eax),%eax
    134a:	3c 39                	cmp    $0x39,%al
    134c:	76 ca                	jbe    1318 <vsprintf+0x7f>
    134e:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
    1354:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
    135a:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    1360:	83 ec 04             	sub    $0x4,%esp
    1363:	68 00 04 00 00       	push   $0x400
    1368:	6a 00                	push   $0x0
    136a:	50                   	push   %eax
    136b:	e8 f9 01 00 00       	call   1569 <memset>
    1370:	83 c4 10             	add    $0x10,%esp
    1373:	8b 45 0c             	mov    0xc(%ebp),%eax
    1376:	0f b6 00             	movzbl (%eax),%eax
    1379:	0f be c0             	movsbl %al,%eax
    137c:	83 f8 64             	cmp    $0x64,%eax
    137f:	74 67                	je     13e8 <vsprintf+0x14f>
    1381:	83 f8 64             	cmp    $0x64,%eax
    1384:	7f 0a                	jg     1390 <vsprintf+0xf7>
    1386:	83 f8 63             	cmp    $0x63,%eax
    1389:	74 18                	je     13a3 <vsprintf+0x10a>
    138b:	e9 d6 00 00 00       	jmp    1466 <vsprintf+0x1cd>
    1390:	83 f8 73             	cmp    $0x73,%eax
    1393:	0f 84 8f 00 00 00    	je     1428 <vsprintf+0x18f>
    1399:	83 f8 78             	cmp    $0x78,%eax
    139c:	74 25                	je     13c3 <vsprintf+0x12a>
    139e:	e9 c3 00 00 00       	jmp    1466 <vsprintf+0x1cd>
    13a3:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    13a9:	8d 50 01             	lea    0x1(%eax),%edx
    13ac:	89 95 dc fb ff ff    	mov    %edx,-0x424(%ebp)
    13b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    13b5:	0f b6 12             	movzbl (%edx),%edx
    13b8:	88 10                	mov    %dl,(%eax)
    13ba:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    13be:	e9 a3 00 00 00       	jmp    1466 <vsprintf+0x1cd>
    13c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13c6:	8b 00                	mov    (%eax),%eax
    13c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13cb:	83 ec 04             	sub    $0x4,%esp
    13ce:	8d 85 dc fb ff ff    	lea    -0x424(%ebp),%eax
    13d4:	50                   	push   %eax
    13d5:	6a 10                	push   $0x10
    13d7:	ff 75 ec             	pushl  -0x14(%ebp)
    13da:	e8 5c fe ff ff       	call   123b <i2a>
    13df:	83 c4 10             	add    $0x10,%esp
    13e2:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    13e6:	eb 7e                	jmp    1466 <vsprintf+0x1cd>
    13e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13eb:	8b 00                	mov    (%eax),%eax
    13ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    13f4:	79 15                	jns    140b <vsprintf+0x172>
    13f6:	f7 5d ec             	negl   -0x14(%ebp)
    13f9:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    13ff:	8d 50 01             	lea    0x1(%eax),%edx
    1402:	89 95 dc fb ff ff    	mov    %edx,-0x424(%ebp)
    1408:	c6 00 2d             	movb   $0x2d,(%eax)
    140b:	83 ec 04             	sub    $0x4,%esp
    140e:	8d 85 dc fb ff ff    	lea    -0x424(%ebp),%eax
    1414:	50                   	push   %eax
    1415:	6a 0a                	push   $0xa
    1417:	ff 75 ec             	pushl  -0x14(%ebp)
    141a:	e8 1c fe ff ff       	call   123b <i2a>
    141f:	83 c4 10             	add    $0x10,%esp
    1422:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    1426:	eb 3e                	jmp    1466 <vsprintf+0x1cd>
    1428:	8b 45 f0             	mov    -0x10(%ebp),%eax
    142b:	8b 10                	mov    (%eax),%edx
    142d:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    1433:	83 ec 08             	sub    $0x8,%esp
    1436:	52                   	push   %edx
    1437:	50                   	push   %eax
    1438:	e8 4d 01 00 00       	call   158a <strcpy>
    143d:	83 c4 10             	add    $0x10,%esp
    1440:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1443:	8b 00                	mov    (%eax),%eax
    1445:	83 ec 0c             	sub    $0xc,%esp
    1448:	50                   	push   %eax
    1449:	e8 54 01 00 00       	call   15a2 <strlen>
    144e:	83 c4 10             	add    $0x10,%esp
    1451:	89 c2                	mov    %eax,%edx
    1453:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    1459:	01 d0                	add    %edx,%eax
    145b:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
    1461:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
    1465:	90                   	nop
    1466:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    146d:	eb 13                	jmp    1482 <vsprintf+0x1e9>
    146f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1472:	8d 50 01             	lea    0x1(%eax),%edx
    1475:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1478:	0f b6 55 eb          	movzbl -0x15(%ebp),%edx
    147c:	88 10                	mov    %dl,(%eax)
    147e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1482:	83 ec 0c             	sub    $0xc,%esp
    1485:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
    148b:	50                   	push   %eax
    148c:	e8 11 01 00 00       	call   15a2 <strlen>
    1491:	83 c4 10             	add    $0x10,%esp
    1494:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1497:	7d 1b                	jge    14b4 <vsprintf+0x21b>
    1499:	83 ec 0c             	sub    $0xc,%esp
    149c:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
    14a2:	50                   	push   %eax
    14a3:	e8 fa 00 00 00       	call   15a2 <strlen>
    14a8:	83 c4 10             	add    $0x10,%esp
    14ab:	89 c2                	mov    %eax,%edx
    14ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14b0:	29 d0                	sub    %edx,%eax
    14b2:	eb 05                	jmp    14b9 <vsprintf+0x220>
    14b4:	b8 00 00 00 00       	mov    $0x0,%eax
    14b9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    14bc:	7f b1                	jg     146f <vsprintf+0x1d6>
    14be:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
    14c4:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
    14ca:	eb 1d                	jmp    14e9 <vsprintf+0x250>
    14cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cf:	8d 50 01             	lea    0x1(%eax),%edx
    14d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14d5:	8b 95 dc fb ff ff    	mov    -0x424(%ebp),%edx
    14db:	8d 4a 01             	lea    0x1(%edx),%ecx
    14de:	89 8d dc fb ff ff    	mov    %ecx,-0x424(%ebp)
    14e4:	0f b6 12             	movzbl (%edx),%edx
    14e7:	88 10                	mov    %dl,(%eax)
    14e9:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    14ef:	0f b6 00             	movzbl (%eax),%eax
    14f2:	84 c0                	test   %al,%al
    14f4:	75 d6                	jne    14cc <vsprintf+0x233>
    14f6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    14fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fd:	0f b6 00             	movzbl (%eax),%eax
    1500:	84 c0                	test   %al,%al
    1502:	0f 85 ab fd ff ff    	jne    12b3 <vsprintf+0x1a>
    1508:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150b:	c6 00 00             	movb   $0x0,(%eax)
    150e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1511:	8b 45 08             	mov    0x8(%ebp),%eax
    1514:	29 c2                	sub    %eax,%edx
    1516:	89 d0                	mov    %edx,%eax
    1518:	c9                   	leave  
    1519:	c3                   	ret    

0000151a <sprintf>:
    151a:	55                   	push   %ebp
    151b:	89 e5                	mov    %esp,%ebp
    151d:	83 ec 18             	sub    $0x18,%esp
    1520:	8d 45 0c             	lea    0xc(%ebp),%eax
    1523:	83 c0 04             	add    $0x4,%eax
    1526:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1529:	8b 45 0c             	mov    0xc(%ebp),%eax
    152c:	83 ec 04             	sub    $0x4,%esp
    152f:	ff 75 f4             	pushl  -0xc(%ebp)
    1532:	50                   	push   %eax
    1533:	ff 75 08             	pushl  0x8(%ebp)
    1536:	e8 5e fd ff ff       	call   1299 <vsprintf>
    153b:	83 c4 10             	add    $0x10,%esp
    153e:	c9                   	leave  
    153f:	c3                   	ret    

00001540 <memcpy>:
    1540:	55                   	push   %ebp
    1541:	89 e5                	mov    %esp,%ebp
    1543:	56                   	push   %esi
    1544:	57                   	push   %edi
    1545:	51                   	push   %ecx
    1546:	8b 7d 08             	mov    0x8(%ebp),%edi
    1549:	8b 75 0c             	mov    0xc(%ebp),%esi
    154c:	8b 4d 10             	mov    0x10(%ebp),%ecx

0000154f <memcpy.1>:
    154f:	83 f9 00             	cmp    $0x0,%ecx
    1552:	74 0b                	je     155f <memcpy.2>
    1554:	3e 8a 06             	mov    %ds:(%esi),%al
    1557:	46                   	inc    %esi
    1558:	26 88 07             	mov    %al,%es:(%edi)
    155b:	47                   	inc    %edi
    155c:	49                   	dec    %ecx
    155d:	eb f0                	jmp    154f <memcpy.1>

0000155f <memcpy.2>:
    155f:	8b 45 08             	mov    0x8(%ebp),%eax
    1562:	59                   	pop    %ecx
    1563:	5f                   	pop    %edi
    1564:	5e                   	pop    %esi
    1565:	89 ec                	mov    %ebp,%esp
    1567:	5d                   	pop    %ebp
    1568:	c3                   	ret    

00001569 <memset>:
    1569:	55                   	push   %ebp
    156a:	89 e5                	mov    %esp,%ebp
    156c:	56                   	push   %esi
    156d:	57                   	push   %edi
    156e:	51                   	push   %ecx
    156f:	8b 7d 08             	mov    0x8(%ebp),%edi
    1572:	8b 55 0c             	mov    0xc(%ebp),%edx
    1575:	8b 4d 10             	mov    0x10(%ebp),%ecx

00001578 <memset.1>:
    1578:	83 f9 00             	cmp    $0x0,%ecx
    157b:	74 06                	je     1583 <memset.2>
    157d:	88 17                	mov    %dl,(%edi)
    157f:	47                   	inc    %edi
    1580:	49                   	dec    %ecx
    1581:	eb f5                	jmp    1578 <memset.1>

00001583 <memset.2>:
    1583:	59                   	pop    %ecx
    1584:	5f                   	pop    %edi
    1585:	5e                   	pop    %esi
    1586:	89 ec                	mov    %ebp,%esp
    1588:	5d                   	pop    %ebp
    1589:	c3                   	ret    

0000158a <strcpy>:
    158a:	55                   	push   %ebp
    158b:	89 e5                	mov    %esp,%ebp
    158d:	8b 75 0c             	mov    0xc(%ebp),%esi
    1590:	8b 7d 08             	mov    0x8(%ebp),%edi

00001593 <strcpy.1>:
    1593:	8a 06                	mov    (%esi),%al
    1595:	46                   	inc    %esi
    1596:	88 07                	mov    %al,(%edi)
    1598:	47                   	inc    %edi
    1599:	3c 00                	cmp    $0x0,%al
    159b:	75 f6                	jne    1593 <strcpy.1>
    159d:	8b 45 08             	mov    0x8(%ebp),%eax
    15a0:	5d                   	pop    %ebp
    15a1:	c3                   	ret    

000015a2 <strlen>:
    15a2:	55                   	push   %ebp
    15a3:	89 e5                	mov    %esp,%ebp
    15a5:	b8 00 00 00 00       	mov    $0x0,%eax
    15aa:	8b 75 08             	mov    0x8(%ebp),%esi

000015ad <strlen.1>:
    15ad:	80 3e 00             	cmpb   $0x0,(%esi)
    15b0:	74 04                	je     15b6 <strlen.2>
    15b2:	46                   	inc    %esi
    15b3:	40                   	inc    %eax
    15b4:	eb f7                	jmp    15ad <strlen.1>

000015b6 <strlen.2>:
    15b6:	5d                   	pop    %ebp
    15b7:	c3                   	ret    

000015b8 <send_recv>:
    15b8:	55                   	push   %ebp
    15b9:	89 e5                	mov    %esp,%ebp
    15bb:	83 ec 18             	sub    $0x18,%esp
    15be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    15c5:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
    15c9:	75 12                	jne    15dd <send_recv+0x25>
    15cb:	83 ec 04             	sub    $0x4,%esp
    15ce:	6a 30                	push   $0x30
    15d0:	6a 00                	push   $0x0
    15d2:	ff 75 10             	pushl  0x10(%ebp)
    15d5:	e8 8f ff ff ff       	call   1569 <memset>
    15da:	83 c4 10             	add    $0x10,%esp
    15dd:	8b 45 08             	mov    0x8(%ebp),%eax
    15e0:	83 f8 01             	cmp    $0x1,%eax
    15e3:	7c 57                	jl     163c <send_recv+0x84>
    15e5:	83 f8 02             	cmp    $0x2,%eax
    15e8:	7e 39                	jle    1623 <send_recv+0x6b>
    15ea:	83 f8 03             	cmp    $0x3,%eax
    15ed:	75 4d                	jne    163c <send_recv+0x84>
    15ef:	83 ec 04             	sub    $0x4,%esp
    15f2:	ff 75 10             	pushl  0x10(%ebp)
    15f5:	ff 75 0c             	pushl  0xc(%ebp)
    15f8:	6a 01                	push   $0x1
    15fa:	e8 91 02 00 00       	call   1890 <sendrec>
    15ff:	83 c4 10             	add    $0x10,%esp
    1602:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1605:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1609:	75 5e                	jne    1669 <send_recv+0xb1>
    160b:	83 ec 04             	sub    $0x4,%esp
    160e:	ff 75 10             	pushl  0x10(%ebp)
    1611:	ff 75 0c             	pushl  0xc(%ebp)
    1614:	6a 02                	push   $0x2
    1616:	e8 75 02 00 00       	call   1890 <sendrec>
    161b:	83 c4 10             	add    $0x10,%esp
    161e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1621:	eb 46                	jmp    1669 <send_recv+0xb1>
    1623:	83 ec 04             	sub    $0x4,%esp
    1626:	ff 75 10             	pushl  0x10(%ebp)
    1629:	ff 75 0c             	pushl  0xc(%ebp)
    162c:	ff 75 08             	pushl  0x8(%ebp)
    162f:	e8 5c 02 00 00       	call   1890 <sendrec>
    1634:	83 c4 10             	add    $0x10,%esp
    1637:	89 45 f4             	mov    %eax,-0xc(%ebp)
    163a:	eb 31                	jmp    166d <send_recv+0xb5>
    163c:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    1640:	74 2a                	je     166c <send_recv+0xb4>
    1642:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    1646:	74 24                	je     166c <send_recv+0xb4>
    1648:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
    164c:	74 1e                	je     166c <send_recv+0xb4>
    164e:	6a 39                	push   $0x39
    1650:	68 60 19 00 00       	push   $0x1960
    1655:	68 60 19 00 00       	push   $0x1960
    165a:	68 6c 19 00 00       	push   $0x196c
    165f:	e8 71 01 00 00       	call   17d5 <assertion_failure>
    1664:	83 c4 10             	add    $0x10,%esp
    1667:	eb 03                	jmp    166c <send_recv+0xb4>
    1669:	90                   	nop
    166a:	eb 01                	jmp    166d <send_recv+0xb5>
    166c:	90                   	nop
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	c9                   	leave  
    1671:	c3                   	ret    

00001672 <memcmp>:
    1672:	55                   	push   %ebp
    1673:	89 e5                	mov    %esp,%ebp
    1675:	83 ec 10             	sub    $0x10,%esp
    1678:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    167c:	74 06                	je     1684 <memcmp+0x12>
    167e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1682:	75 0c                	jne    1690 <memcmp+0x1e>
    1684:	8b 55 08             	mov    0x8(%ebp),%edx
    1687:	8b 45 0c             	mov    0xc(%ebp),%eax
    168a:	29 c2                	sub    %eax,%edx
    168c:	89 d0                	mov    %edx,%eax
    168e:	eb 56                	jmp    16e6 <memcmp+0x74>
    1690:	8b 45 08             	mov    0x8(%ebp),%eax
    1693:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1696:	8b 45 0c             	mov    0xc(%ebp),%eax
    1699:	89 45 f8             	mov    %eax,-0x8(%ebp)
    169c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16a3:	eb 34                	jmp    16d9 <memcmp+0x67>
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	0f b6 10             	movzbl (%eax),%edx
    16ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ae:	0f b6 00             	movzbl (%eax),%eax
    16b1:	38 c2                	cmp    %al,%dl
    16b3:	74 18                	je     16cd <memcmp+0x5b>
    16b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b8:	0f b6 00             	movzbl (%eax),%eax
    16bb:	0f be d0             	movsbl %al,%edx
    16be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c1:	0f b6 00             	movzbl (%eax),%eax
    16c4:	0f be c0             	movsbl %al,%eax
    16c7:	29 c2                	sub    %eax,%edx
    16c9:	89 d0                	mov    %edx,%eax
    16cb:	eb 19                	jmp    16e6 <memcmp+0x74>
    16cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    16d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    16d5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    16d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16dc:	3b 45 10             	cmp    0x10(%ebp),%eax
    16df:	7c c4                	jl     16a5 <memcmp+0x33>
    16e1:	b8 00 00 00 00       	mov    $0x0,%eax
    16e6:	c9                   	leave  
    16e7:	c3                   	ret    

000016e8 <strcmp>:
    16e8:	55                   	push   %ebp
    16e9:	89 e5                	mov    %esp,%ebp
    16eb:	83 ec 10             	sub    $0x10,%esp
    16ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    16f2:	74 06                	je     16fa <strcmp+0x12>
    16f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16f8:	75 0c                	jne    1706 <strcmp+0x1e>
    16fa:	8b 55 08             	mov    0x8(%ebp),%edx
    16fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1700:	29 c2                	sub    %eax,%edx
    1702:	89 d0                	mov    %edx,%eax
    1704:	eb 53                	jmp    1759 <strcmp+0x71>
    1706:	8b 45 08             	mov    0x8(%ebp),%eax
    1709:	89 45 fc             	mov    %eax,-0x4(%ebp)
    170c:	8b 45 0c             	mov    0xc(%ebp),%eax
    170f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1712:	eb 18                	jmp    172c <strcmp+0x44>
    1714:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1717:	0f b6 10             	movzbl (%eax),%edx
    171a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    171d:	0f b6 00             	movzbl (%eax),%eax
    1720:	38 c2                	cmp    %al,%dl
    1722:	75 1e                	jne    1742 <strcmp+0x5a>
    1724:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1728:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    172c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172f:	0f b6 00             	movzbl (%eax),%eax
    1732:	84 c0                	test   %al,%al
    1734:	74 0d                	je     1743 <strcmp+0x5b>
    1736:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1739:	0f b6 00             	movzbl (%eax),%eax
    173c:	84 c0                	test   %al,%al
    173e:	75 d4                	jne    1714 <strcmp+0x2c>
    1740:	eb 01                	jmp    1743 <strcmp+0x5b>
    1742:	90                   	nop
    1743:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1746:	0f b6 00             	movzbl (%eax),%eax
    1749:	0f be d0             	movsbl %al,%edx
    174c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174f:	0f b6 00             	movzbl (%eax),%eax
    1752:	0f be c0             	movsbl %al,%eax
    1755:	29 c2                	sub    %eax,%edx
    1757:	89 d0                	mov    %edx,%eax
    1759:	c9                   	leave  
    175a:	c3                   	ret    

0000175b <strcat>:
    175b:	55                   	push   %ebp
    175c:	89 e5                	mov    %esp,%ebp
    175e:	83 ec 10             	sub    $0x10,%esp
    1761:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1765:	74 06                	je     176d <strcat+0x12>
    1767:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    176b:	75 07                	jne    1774 <strcat+0x19>
    176d:	b8 00 00 00 00       	mov    $0x0,%eax
    1772:	eb 44                	jmp    17b8 <strcat+0x5d>
    1774:	8b 45 08             	mov    0x8(%ebp),%eax
    1777:	89 45 fc             	mov    %eax,-0x4(%ebp)
    177a:	eb 04                	jmp    1780 <strcat+0x25>
    177c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1780:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1783:	0f b6 00             	movzbl (%eax),%eax
    1786:	84 c0                	test   %al,%al
    1788:	75 f2                	jne    177c <strcat+0x21>
    178a:	8b 45 0c             	mov    0xc(%ebp),%eax
    178d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1790:	eb 13                	jmp    17a5 <strcat+0x4a>
    1792:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1795:	0f b6 10             	movzbl (%eax),%edx
    1798:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179b:	88 10                	mov    %dl,(%eax)
    179d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    17a1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    17a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a8:	0f b6 00             	movzbl (%eax),%eax
    17ab:	84 c0                	test   %al,%al
    17ad:	75 e3                	jne    1792 <strcat+0x37>
    17af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b2:	c6 00 00             	movb   $0x0,(%eax)
    17b5:	8b 45 08             	mov    0x8(%ebp),%eax
    17b8:	c9                   	leave  
    17b9:	c3                   	ret    

000017ba <spin>:
    17ba:	55                   	push   %ebp
    17bb:	89 e5                	mov    %esp,%ebp
    17bd:	83 ec 08             	sub    $0x8,%esp
    17c0:	83 ec 08             	sub    $0x8,%esp
    17c3:	ff 75 08             	pushl  0x8(%ebp)
    17c6:	68 ae 19 00 00       	push   $0x19ae
    17cb:	e8 29 fa ff ff       	call   11f9 <printl>
    17d0:	83 c4 10             	add    $0x10,%esp
    17d3:	eb fe                	jmp    17d3 <spin+0x19>

000017d5 <assertion_failure>:
    17d5:	55                   	push   %ebp
    17d6:	89 e5                	mov    %esp,%ebp
    17d8:	83 ec 08             	sub    $0x8,%esp
    17db:	83 ec 08             	sub    $0x8,%esp
    17de:	ff 75 14             	pushl  0x14(%ebp)
    17e1:	ff 75 10             	pushl  0x10(%ebp)
    17e4:	ff 75 0c             	pushl  0xc(%ebp)
    17e7:	ff 75 08             	pushl  0x8(%ebp)
    17ea:	6a 03                	push   $0x3
    17ec:	68 c4 19 00 00       	push   $0x19c4
    17f1:	e8 03 fa ff ff       	call   11f9 <printl>
    17f6:	83 c4 20             	add    $0x20,%esp
    17f9:	83 ec 0c             	sub    $0xc,%esp
    17fc:	68 f9 19 00 00       	push   $0x19f9
    1801:	e8 b4 ff ff ff       	call   17ba <spin>
    1806:	83 c4 10             	add    $0x10,%esp
    1809:	0f 0b                	ud2    
    180b:	90                   	nop
    180c:	c9                   	leave  
    180d:	c3                   	ret    

0000180e <write>:
    180e:	55                   	push   %ebp
    180f:	89 e5                	mov    %esp,%ebp
    1811:	83 ec 38             	sub    $0x38,%esp
    1814:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%ebp)
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1821:	8b 45 0c             	mov    0xc(%ebp),%eax
    1824:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1827:	8b 45 10             	mov    0x10(%ebp),%eax
    182a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    182d:	83 ec 04             	sub    $0x4,%esp
    1830:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1833:	50                   	push   %eax
    1834:	6a 03                	push   $0x3
    1836:	6a 03                	push   $0x3
    1838:	e8 7b fd ff ff       	call   15b8 <send_recv>
    183d:	83 c4 10             	add    $0x10,%esp
    1840:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1843:	c9                   	leave  
    1844:	c3                   	ret    

00001845 <exit>:
    1845:	55                   	push   %ebp
    1846:	89 e5                	mov    %esp,%ebp
    1848:	83 ec 38             	sub    $0x38,%esp
    184b:	c7 45 cc 11 00 00 00 	movl   $0x11,-0x34(%ebp)
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1858:	83 ec 04             	sub    $0x4,%esp
    185b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    185e:	50                   	push   %eax
    185f:	6a 04                	push   $0x4
    1861:	6a 03                	push   $0x3
    1863:	e8 50 fd ff ff       	call   15b8 <send_recv>
    1868:	83 c4 10             	add    $0x10,%esp
    186b:	8b 45 cc             	mov    -0x34(%ebp),%eax
    186e:	83 f8 12             	cmp    $0x12,%eax
    1871:	74 19                	je     188c <exit+0x47>
    1873:	6a 26                	push   $0x26
    1875:	68 0d 1a 00 00       	push   $0x1a0d
    187a:	68 0d 1a 00 00       	push   $0x1a0d
    187f:	68 18 1a 00 00       	push   $0x1a18
    1884:	e8 4c ff ff ff       	call   17d5 <assertion_failure>
    1889:	83 c4 10             	add    $0x10,%esp
    188c:	90                   	nop
    188d:	c9                   	leave  
    188e:	c3                   	ret    
    188f:	90                   	nop

00001890 <sendrec>:
    1890:	53                   	push   %ebx
    1891:	51                   	push   %ecx
    1892:	52                   	push   %edx
    1893:	b8 01 00 00 00       	mov    $0x1,%eax
    1898:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    189c:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    18a0:	8b 54 24 18          	mov    0x18(%esp),%edx
    18a4:	cd 90                	int    $0x90
    18a6:	5a                   	pop    %edx
    18a7:	59                   	pop    %ecx
    18a8:	5b                   	pop    %ebx
    18a9:	c3                   	ret    

000018aa <printx>:
    18aa:	52                   	push   %edx
    18ab:	b8 00 00 00 00       	mov    $0x0,%eax
    18b0:	8b 54 24 08          	mov    0x8(%esp),%edx
    18b4:	cd 90                	int    $0x90
    18b6:	5a                   	pop    %edx
    18b7:	c3                   	ret    

Disassembly of section .rodata:

000018b8 <.rodata>:
    18b8:	52                   	push   %edx
    18b9:	65 61                	gs popa 
    18bb:	64 69 6e 67 20 73 74 	imul   $0x72747320,%fs:0x67(%esi),%ebp
    18c2:	72 
    18c3:	69 6e 67 20 2e 2e 2e 	imul   $0x2e2e2e20,0x67(%esi),%ebp
    18ca:	0a 00                	or     (%eax),%al
    18cc:	54                   	push   %esp
    18cd:	68 65 20 73 74       	push   $0x74732065
    18d2:	72 69                	jb     193d <printx+0x93>
    18d4:	6e                   	outsb  %ds:(%esi),(%dx)
    18d5:	67 20 69 73          	and    %ch,0x73(%bx,%di)
    18d9:	3a 20                	cmp    (%eax),%ah
    18db:	25 73 0a 00 00       	and    $0xa73,%eax
    18e0:	0a 2a                	or     (%edx),%ch
    18e2:	2a 2a                	sub    (%edx),%ch
    18e4:	2a 2a                	sub    (%edx),%ch
    18e6:	20 54 68 69          	and    %dl,0x69(%eax,%ebp,2)
    18ea:	73 20                	jae    190c <printx+0x62>
    18ec:	70 72                	jo     1960 <printx+0xb6>
    18ee:	6f                   	outsl  %ds:(%esi),(%dx)
    18ef:	67 72 61             	addr16 jb 1953 <printx+0xa9>
    18f2:	6d                   	insl   (%dx),%es:(%edi)
    18f3:	20 68 61             	and    %ch,0x61(%eax)
    18f6:	73 20                	jae    1918 <printx+0x6e>
    18f8:	62 65 65             	bound  %esp,0x65(%ebp)
    18fb:	6e                   	outsb  %ds:(%esi),(%dx)
    18fc:	20 61 74             	and    %ah,0x74(%ecx)
    18ff:	74 61                	je     1962 <printx+0xb8>
    1901:	63 6b 65             	arpl   %bp,0x65(%ebx)
    1904:	64 21 20             	and    %esp,%fs:(%eax)
    1907:	2a 2a                	sub    (%edx),%ch
    1909:	2a 2a                	sub    (%edx),%ch
    190b:	2a 0a                	sub    (%edx),%cl
    190d:	00 00                	add    %al,(%eax)
    190f:	00 2a                	add    %ch,(%edx)
    1911:	2a 2a                	sub    (%edx),%ch
    1913:	2a 2a                	sub    (%edx),%ch
    1915:	20 53 54             	and    %dl,0x54(%ebx)
    1918:	41                   	inc    %ecx
    1919:	43                   	inc    %ebx
    191a:	4b                   	dec    %ebx
    191b:	20 4f 56             	and    %cl,0x56(%edi)
    191e:	45                   	inc    %ebp
    191f:	52                   	push   %edx
    1920:	46                   	inc    %esi
    1921:	4c                   	dec    %esp
    1922:	4f                   	dec    %edi
    1923:	57                   	push   %edi
    1924:	20 41 54             	and    %al,0x54(%ecx)
    1927:	54                   	push   %esp
    1928:	41                   	inc    %ecx
    1929:	43                   	inc    %ebx
    192a:	4b                   	dec    %ebx
    192b:	20 53 55             	and    %dl,0x55(%ebx)
    192e:	43                   	inc    %ebx
    192f:	43                   	inc    %ebx
    1930:	45                   	inc    %ebp
    1931:	45                   	inc    %ebp
    1932:	44                   	inc    %esp
    1933:	45                   	inc    %ebp
    1934:	44                   	inc    %esp
    1935:	20 2a                	and    %ch,(%edx)
    1937:	2a 2a                	sub    (%edx),%ch
    1939:	2a 2a                	sub    (%edx),%ch
    193b:	0a 00                	or     (%eax),%al
    193d:	63 68 6f             	arpl   %bp,0x6f(%eax)
    1940:	73 65                	jae    19a7 <printx+0xfd>
    1942:	20 73 74             	and    %dh,0x74(%ebx)
    1945:	72 3a                	jb     1981 <printx+0xd7>
    1947:	20 25 64 0a 00 6c    	and    %ah,0x6c000a64
    194d:	69 62 2f 70 72 69 6e 	imul   $0x6e697270,0x2f(%edx),%esp
    1954:	74 66                	je     19bc <printx+0x112>
    1956:	2e 63 00             	arpl   %ax,%cs:(%eax)
    1959:	63 20                	arpl   %sp,(%eax)
    195b:	3d 3d 20 69 00       	cmp    $0x69203d,%eax
    1960:	6c                   	insb   (%dx),%es:(%edi)
    1961:	69 62 2f 6d 69 73 63 	imul   $0x6373696d,0x2f(%edx),%esp
    1968:	2e 63 00             	arpl   %ax,%cs:(%eax)
    196b:	00 28                	add    %ch,(%eax)
    196d:	66 75 6e             	data16 jne 19de <printx+0x134>
    1970:	63 74 69 6f          	arpl   %si,0x6f(%ecx,%ebp,2)
    1974:	6e                   	outsb  %ds:(%esi),(%dx)
    1975:	20 3d 3d 20 42 4f    	and    %bh,0x4f42203d
    197b:	54                   	push   %esp
    197c:	48                   	dec    %eax
    197d:	29 20                	sub    %esp,(%eax)
    197f:	7c 7c                	jl     19fd <printx+0x153>
    1981:	20 28                	and    %ch,(%eax)
    1983:	66 75 6e             	data16 jne 19f4 <printx+0x14a>
    1986:	63 74 69 6f          	arpl   %si,0x6f(%ecx,%ebp,2)
    198a:	6e                   	outsb  %ds:(%esi),(%dx)
    198b:	20 3d 3d 20 53 45    	and    %bh,0x4553203d
    1991:	4e                   	dec    %esi
    1992:	44                   	inc    %esp
    1993:	29 20                	sub    %esp,(%eax)
    1995:	7c 7c                	jl     1a13 <printx+0x169>
    1997:	20 28                	and    %ch,(%eax)
    1999:	66 75 6e             	data16 jne 1a0a <printx+0x160>
    199c:	63 74 69 6f          	arpl   %si,0x6f(%ecx,%ebp,2)
    19a0:	6e                   	outsb  %ds:(%esi),(%dx)
    19a1:	20 3d 3d 20 52 45    	and    %bh,0x4552203d
    19a7:	43                   	inc    %ebx
    19a8:	45                   	inc    %ebp
    19a9:	49                   	dec    %ecx
    19aa:	56                   	push   %esi
    19ab:	45                   	inc    %ebp
    19ac:	29 00                	sub    %eax,(%eax)
    19ae:	0a 73 70             	or     0x70(%ebx),%dh
    19b1:	69 6e 6e 69 6e 67 20 	imul   $0x20676e69,0x6e(%esi),%ebp
    19b8:	69 6e 20 25 73 20 2e 	imul   $0x2e207325,0x20(%esi),%ebp
    19bf:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    19c3:	00 25 63 20 20 61    	add    %ah,0x61202063
    19c9:	73 73                	jae    1a3e <printx+0x194>
    19cb:	65 72 74             	gs jb  1a42 <printx+0x198>
    19ce:	28 25 73 29 20 66    	sub    %ah,0x66202973
    19d4:	61                   	popa   
    19d5:	69 6c 65 64 3a 20 66 	imul   $0x6966203a,0x64(%ebp,%eiz,2),%ebp
    19dc:	69 
    19dd:	6c                   	insb   (%dx),%es:(%edi)
    19de:	65 3a 20             	cmp    %gs:(%eax),%ah
    19e1:	25 73 2c 20 62       	and    $0x62202c73,%eax
    19e6:	61                   	popa   
    19e7:	73 65                	jae    1a4e <printx+0x1a4>
    19e9:	5f                   	pop    %edi
    19ea:	66 69 6c 65 3a 20 25 	imul   $0x2520,0x3a(%ebp,%eiz,2),%bp
    19f1:	73 2c                	jae    1a1f <printx+0x175>
    19f3:	20 6c 6e 25          	and    %ch,0x25(%esi,%ebp,2)
    19f7:	64 00 61 73          	add    %ah,%fs:0x73(%ecx)
    19fb:	73 65                	jae    1a62 <printx+0x1b8>
    19fd:	72 74                	jb     1a73 <printx+0x1c9>
    19ff:	69 6f 6e 5f 66 61 69 	imul   $0x6961665f,0x6e(%edi),%ebp
    1a06:	6c                   	insb   (%dx),%es:(%edi)
    1a07:	75 72                	jne    1a7b <printx+0x1d1>
    1a09:	65 28 29             	sub    %ch,%gs:(%ecx)
    1a0c:	00 6c 69 62          	add    %ch,0x62(%ecx,%ebp,2)
    1a10:	2f                   	das    
    1a11:	65 78 69             	gs js  1a7d <printx+0x1d3>
    1a14:	74 2e                	je     1a44 <printx+0x19a>
    1a16:	63 00                	arpl   %ax,(%eax)
    1a18:	6d                   	insl   (%dx),%es:(%edi)
    1a19:	73 67                	jae    1a82 <printx+0x1d8>
    1a1b:	2e 74 79             	je,pn  1a97 <printx+0x1ed>
    1a1e:	70 65                	jo     1a85 <printx+0x1db>
    1a20:	20 3d 3d 20 53 59    	and    %bh,0x5953203d
    1a26:	53                   	push   %ebx
    1a27:	43                   	inc    %ebx
    1a28:	41                   	inc    %ecx
    1a29:	4c                   	dec    %esp
    1a2a:	4c                   	dec    %esp
    1a2b:	5f                   	pop    %edi
    1a2c:	52                   	push   %edx
    1a2d:	45                   	inc    %ebp
    1a2e:	54                   	push   %esp
	...

Disassembly of section .eh_frame:

00001a30 <__bss_start-0x1220>:
    1a30:	14 00                	adc    $0x0,%al
    1a32:	00 00                	add    %al,(%eax)
    1a34:	00 00                	add    %al,(%eax)
    1a36:	00 00                	add    %al,(%eax)
    1a38:	01 7a 52             	add    %edi,0x52(%edx)
    1a3b:	00 01                	add    %al,(%ecx)
    1a3d:	7c 08                	jl     1a47 <printx+0x19d>
    1a3f:	01 1b                	add    %ebx,(%ebx)
    1a41:	0c 04                	or     $0x4,%al
    1a43:	04 88                	add    $0x88,%al
    1a45:	01 00                	add    %eax,(%eax)
    1a47:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1a4a:	00 00                	add    %al,(%eax)
    1a4c:	1c 00                	sbb    $0x0,%al
    1a4e:	00 00                	add    %al,(%eax)
    1a50:	b0 f5                	mov    $0xf5,%al
    1a52:	ff                   	(bad)  
    1a53:	ff 50 00             	call   *0x0(%eax)
    1a56:	00 00                	add    %al,(%eax)
    1a58:	00 41 0e             	add    %al,0xe(%ecx)
    1a5b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1a61:	02 4c c5 0c          	add    0xc(%ebp,%eax,8),%cl
    1a65:	04 04                	add    $0x4,%al
    1a67:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1a6a:	00 00                	add    %al,(%eax)
    1a6c:	3c 00                	cmp    $0x0,%al
    1a6e:	00 00                	add    %al,(%eax)
    1a70:	e0 f5                	loopne 1a67 <printx+0x1bd>
    1a72:	ff                   	(bad)  
    1a73:	ff 29                	ljmp   *(%ecx)
    1a75:	00 00                	add    %al,(%eax)
    1a77:	00 00                	add    %al,(%eax)
    1a79:	41                   	inc    %ecx
    1a7a:	0e                   	push   %cs
    1a7b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1a81:	65 c5 0c 04          	lds    %gs:(%esp,%eax,1),%ecx
    1a85:	04 00                	add    $0x0,%al
    1a87:	00 28                	add    %ch,(%eax)
    1a89:	00 00                	add    %al,(%eax)
    1a8b:	00 5c 00 00          	add    %bl,0x0(%eax,%eax,1)
    1a8f:	00 e9                	add    %ch,%cl
    1a91:	f5                   	cmc    
    1a92:	ff                   	(bad)  
    1a93:	ff 02                	incl   (%edx)
    1a95:	01 00                	add    %eax,(%eax)
    1a97:	00 00                	add    %al,(%eax)
    1a99:	44                   	inc    %esp
    1a9a:	0c 01                	or     $0x1,%al
    1a9c:	00 47 10             	add    %al,0x10(%edi)
    1a9f:	05 02 75 00 43       	add    $0x43007502,%eax
    1aa4:	0f 03 75 7c          	lsl    0x7c(%ebp),%esi
    1aa8:	06                   	push   %es
    1aa9:	02 ef                	add    %bh,%ch
    1aab:	0c 01                	or     $0x1,%al
    1aad:	00 41 c5             	add    %al,-0x3b(%ecx)
    1ab0:	43                   	inc    %ebx
    1ab1:	0c 04                	or     $0x4,%al
    1ab3:	04 1c                	add    $0x1c,%al
    1ab5:	00 00                	add    %al,(%eax)
    1ab7:	00 88 00 00 00 d2    	add    %cl,-0x2e000000(%eax)
    1abd:	f6 ff                	idiv   %bh
    1abf:	ff 6b 00             	ljmp   *0x0(%ebx)
    1ac2:	00 00                	add    %al,(%eax)
    1ac4:	00 41 0e             	add    %al,0xe(%ecx)
    1ac7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1acd:	02 67 c5             	add    -0x3b(%edi),%ah
    1ad0:	0c 04                	or     $0x4,%al
    1ad2:	04 00                	add    $0x0,%al
    1ad4:	1c 00                	sbb    $0x0,%al
    1ad6:	00 00                	add    %al,(%eax)
    1ad8:	a8 00                	test   $0x0,%al
    1ada:	00 00                	add    %al,(%eax)
    1adc:	1d f7 ff ff 42       	sbb    $0x42fffff7,%eax
    1ae1:	00 00                	add    %al,(%eax)
    1ae3:	00 00                	add    %al,(%eax)
    1ae5:	41                   	inc    %ecx
    1ae6:	0e                   	push   %cs
    1ae7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1aed:	7e c5                	jle    1ab4 <printx+0x20a>
    1aef:	0c 04                	or     $0x4,%al
    1af1:	04 00                	add    $0x0,%al
    1af3:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1af6:	00 00                	add    %al,(%eax)
    1af8:	c8 00 00 00          	enter  $0x0,$0x0
    1afc:	3f                   	aas    
    1afd:	f7 ff                	idiv   %edi
    1aff:	ff 5e 00             	lcall  *0x0(%esi)
    1b02:	00 00                	add    %al,(%eax)
    1b04:	00 41 0e             	add    %al,0xe(%ecx)
    1b07:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1b0d:	02 5a c5             	add    -0x3b(%edx),%bl
    1b10:	0c 04                	or     $0x4,%al
    1b12:	04 00                	add    $0x0,%al
    1b14:	1c 00                	sbb    $0x0,%al
    1b16:	00 00                	add    %al,(%eax)
    1b18:	e8 00 00 00 7d       	call   7d001b1d <__bss_start+0x7cffeecd>
    1b1d:	f7 ff                	idiv   %edi
    1b1f:	ff 81 02 00 00 00    	incl   0x2(%ecx)
    1b25:	41                   	inc    %ecx
    1b26:	0e                   	push   %cs
    1b27:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1b2d:	03 7d 02             	add    0x2(%ebp),%edi
    1b30:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    1b33:	04 1c                	add    $0x1c,%al
    1b35:	00 00                	add    %al,(%eax)
    1b37:	00 08                	add    %cl,(%eax)
    1b39:	01 00                	add    %eax,(%eax)
    1b3b:	00 de                	add    %bl,%dh
    1b3d:	f9                   	stc    
    1b3e:	ff                   	(bad)  
    1b3f:	ff 26                	jmp    *(%esi)
    1b41:	00 00                	add    %al,(%eax)
    1b43:	00 00                	add    %al,(%eax)
    1b45:	41                   	inc    %ecx
    1b46:	0e                   	push   %cs
    1b47:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1b4d:	62                   	(bad)  
    1b4e:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    1b51:	04 00                	add    $0x0,%al
    1b53:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1b56:	00 00                	add    %al,(%eax)
    1b58:	28 01                	sub    %al,(%ecx)
    1b5a:	00 00                	add    %al,(%eax)
    1b5c:	5c                   	pop    %esp
    1b5d:	fa                   	cli    
    1b5e:	ff                   	(bad)  
    1b5f:	ff                   	(bad)  
    1b60:	ba 00 00 00 00       	mov    $0x0,%edx
    1b65:	41                   	inc    %ecx
    1b66:	0e                   	push   %cs
    1b67:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1b6d:	02 b6 c5 0c 04 04    	add    0x4040cc5(%esi),%dh
    1b73:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1b76:	00 00                	add    %al,(%eax)
    1b78:	48                   	dec    %eax
    1b79:	01 00                	add    %eax,(%eax)
    1b7b:	00 f6                	add    %dh,%dh
    1b7d:	fa                   	cli    
    1b7e:	ff                   	(bad)  
    1b7f:	ff 76 00             	pushl  0x0(%esi)
    1b82:	00 00                	add    %al,(%eax)
    1b84:	00 41 0e             	add    %al,0xe(%ecx)
    1b87:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1b8d:	02 72 c5             	add    -0x3b(%edx),%dh
    1b90:	0c 04                	or     $0x4,%al
    1b92:	04 00                	add    $0x0,%al
    1b94:	1c 00                	sbb    $0x0,%al
    1b96:	00 00                	add    %al,(%eax)
    1b98:	68 01 00 00 4c       	push   $0x4c000001
    1b9d:	fb                   	sti    
    1b9e:	ff                   	(bad)  
    1b9f:	ff 73 00             	pushl  0x0(%ebx)
    1ba2:	00 00                	add    %al,(%eax)
    1ba4:	00 41 0e             	add    %al,0xe(%ecx)
    1ba7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1bad:	02 6f c5             	add    -0x3b(%edi),%ch
    1bb0:	0c 04                	or     $0x4,%al
    1bb2:	04 00                	add    $0x0,%al
    1bb4:	1c 00                	sbb    $0x0,%al
    1bb6:	00 00                	add    %al,(%eax)
    1bb8:	88 01                	mov    %al,(%ecx)
    1bba:	00 00                	add    %al,(%eax)
    1bbc:	9f                   	lahf   
    1bbd:	fb                   	sti    
    1bbe:	ff                   	(bad)  
    1bbf:	ff 5f 00             	lcall  *0x0(%edi)
    1bc2:	00 00                	add    %al,(%eax)
    1bc4:	00 41 0e             	add    %al,0xe(%ecx)
    1bc7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1bcd:	02 5b c5             	add    -0x3b(%ebx),%bl
    1bd0:	0c 04                	or     $0x4,%al
    1bd2:	04 00                	add    $0x0,%al
    1bd4:	18 00                	sbb    %al,(%eax)
    1bd6:	00 00                	add    %al,(%eax)
    1bd8:	a8 01                	test   $0x1,%al
    1bda:	00 00                	add    %al,(%eax)
    1bdc:	de fb                	fdivrp %st,%st(3)
    1bde:	ff                   	(bad)  
    1bdf:	ff 1b                	lcall  *(%ebx)
    1be1:	00 00                	add    %al,(%eax)
    1be3:	00 00                	add    %al,(%eax)
    1be5:	41                   	inc    %ecx
    1be6:	0e                   	push   %cs
    1be7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1bed:	00 00                	add    %al,(%eax)
    1bef:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1bf2:	00 00                	add    %al,(%eax)
    1bf4:	c4 01                	les    (%ecx),%eax
    1bf6:	00 00                	add    %al,(%eax)
    1bf8:	dd fb                	(bad)  
    1bfa:	ff                   	(bad)  
    1bfb:	ff                   	(bad)  
    1bfc:	39 00                	cmp    %eax,(%eax)
    1bfe:	00 00                	add    %al,(%eax)
    1c00:	00 41 0e             	add    %al,0xe(%ecx)
    1c03:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1c09:	75 c5                	jne    1bd0 <printx+0x326>
    1c0b:	0c 04                	or     $0x4,%al
    1c0d:	04 00                	add    $0x0,%al
    1c0f:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1c12:	00 00                	add    %al,(%eax)
    1c14:	e4 01                	in     $0x1,%al
    1c16:	00 00                	add    %al,(%eax)
    1c18:	f6 fb                	idiv   %bl
    1c1a:	ff                   	(bad)  
    1c1b:	ff 37                	pushl  (%edi)
    1c1d:	00 00                	add    %al,(%eax)
    1c1f:	00 00                	add    %al,(%eax)
    1c21:	41                   	inc    %ecx
    1c22:	0e                   	push   %cs
    1c23:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1c29:	73 c5                	jae    1bf0 <printx+0x346>
    1c2b:	0c 04                	or     $0x4,%al
    1c2d:	04 00                	add    $0x0,%al
    1c2f:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1c32:	00 00                	add    %al,(%eax)
    1c34:	04 02                	add    $0x2,%al
    1c36:	00 00                	add    %al,(%eax)
    1c38:	0d fc ff ff 4a       	or     $0x4afffffc,%eax
    1c3d:	00 00                	add    %al,(%eax)
    1c3f:	00 00                	add    %al,(%eax)
    1c41:	41                   	inc    %ecx
    1c42:	0e                   	push   %cs
    1c43:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    1c49:	02 46 c5             	add    -0x3b(%esi),%al
    1c4c:	0c 04                	or     $0x4,%al
    1c4e:	04 00                	add    $0x0,%al

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    %edi
   1:	43                   	inc    %ebx
   2:	43                   	inc    %ebx
   3:	3a 20                	cmp    (%eax),%ah
   5:	28 55 62             	sub    %dl,0x62(%ebp)
   8:	75 6e                	jne    78 <P_LDT+0x2c>
   a:	74 75                	je     81 <P_LDT+0x35>
   c:	20 35 2e 34 2e 30    	and    %dh,0x302e342e
  12:	2d 36 75 62 75       	sub    $0x75627536,%eax
  17:	6e                   	outsb  %ds:(%esi),(%dx)
  18:	74 75                	je     8f <P_LDT+0x43>
  1a:	31 7e 31             	xor    %edi,0x31(%esi)
  1d:	36 2e 30 34 2e       	ss xor %dh,%cs:(%esi,%ebp,1)
  22:	31 32                	xor    %esi,(%edx)
  24:	29 20                	sub    %esp,(%eax)
  26:	35 2e 34 2e 30       	xor    $0x302e342e,%eax
  2b:	20 32                	and    %dh,(%edx)
  2d:	30 31                	xor    %dh,(%ecx)
  2f:	36 30 36             	xor    %dh,%ss:(%esi)
  32:	30 39                	xor    %bh,(%ecx)
	...
