float disH, disW;
float disH2, disW2;
float mouy, moux;
int event = 0;

int seed = 10;
int seed2 = r(seed*2);
int seed3 = r(seed*3);
int seed4 = r(seed*4);
int seed5 = r(seed*5);
int seed6 = r(seed*6);

float scale = 0.035;
int xPos = 0;
int yPos = 0;
float zPos = 0;
int map[][], map2[][], map3[][], map4[][], map5[][];
int xPl = 0, yPl = 0;
int xFantomCamera = 0, yFantomCamera = 0;
float size = 30;
int plspeed = 1;
int bl0[] = {};
int bl1[] = {};
int bl2[] = {};
int bl3[] = {};
// значение (id значения) - описание
// 1 - уничтожено (0) или установлено (1)
// 2 - x (по карте map2)
// 3 - y (по карте map2)
// 4 - айди установленного блока (только если значение 1 равняется 1)

int i, i2, i3, delframe = 10;
String typeblockstr = "Ent";
int setblocktype = 1;
int setblockinvid = 0;
int inv[][] = {
  {1,1},
  {2,1},
  {3,1},
};
float cloudsX = 0, cloudsY = 0, frameCl = 0;
int frameSpeed = 3, icl = 0;
Boolean clouds = true;
int updateNoiseMapTick = 1;
int atmoInt = 20, atmoUpdateTick = 15, atmoRand = rand(10000,999999);
float atmoX;

rendernoiseThreadclass rendernoiseThread = new rendernoiseThreadclass();
rendermapThreadclass rendermapThread = new rendermapThreadclass();
rendermap2Threadclass rendermap2Thread = new rendermap2Threadclass();
renderatmonoiseThreadclass renderatmonoiseThread = new renderatmonoiseThreadclass();
rendercloudsThreadclass rendercloudsThread = new rendercloudsThreadclass();
saveBl saveBl = new saveBl();

int noisecenter(int px, int py) {
  return map[round((((map.length-2)/2)))+px-xFantomCamera][round((((map[0].length-2)/2)))+py-yFantomCamera];
}
int noisecenter2(int px, int py) {
  return map2[round((((map.length-2)/2)))+1+px-xFantomCamera][round((((map[0].length-2)/2)))+1+py-yFantomCamera];
}
int noisecenter4(int px, int py) {
  return map4[round((((map4.length-2)/2)))+px-xFantomCamera][round((((map4[0].length-2)/2)))+py-yFantomCamera];
}
int noisecenter5(int px, int py) {
  return map5[round((((map5.length-2)/2)))+1+px-xFantomCamera][round((((map5[0].length-2)/2)))+1+py-yFantomCamera];
}
int cplx() {
  return round((((map.length-2)/2)))-xFantomCamera;
}
int cply() {
  return round((((map[0].length-2)/2)))-yFantomCamera;
}
float startw, starth;

// MODCODE
String setupCodeFile[];
Boolean errorCode = false;
String setupCode = "";

JSONObject saveBljson;

PShader bloom;

void setup() {
  frameRate(60);
  //fullScreen();
  size(1080,720);
  surface.setResizable(true);
  surface.setLocation(100, 100);
  disW = width;
  disH = height;
  startw = width;
  starth = height;
  disH2 = disH/2;
  disW2 = disW/2;
  map = new int[round(width/size)+2][round(height/size)+2];
  map2 = new int[round(width/size)+4+2][round(height/size)+4+2];
  map3 = new int[round(width/size)+4+2][round(height/size)+4+2];
  map4 = new int[round(width/size)+2][round(height/size)+2];
  map5 = new int[round(width/(size*2))+2][round(height/(size*2))+2];
  /*codemod = loadJSONObject("testcode.txt");
  print(codemod.size()+"\n");
  for (int i = 0 ; i < codemod.size(); i++) {
    print(i+": /"+codemod.getJSONObject(str(i)).getInt("command")+"/\n");
    // 1 - print
    // 2 - edit var scale
    // 3 - edit var start xPl
    // 3 - edit var start yPl
    if(codemod.getJSONObject(str(i)).getInt("command") == 1) {
      print(codemod.getJSONObject(str(i)).getString("arg1"));
    } else if(codemod.getJSONObject(str(i)).getInt("command") == 2) {
      scale = codemod.getJSONObject(str(i)).getFloat("arg1");
    } else if(codemod.getJSONObject(str(i)).getInt("command") == 3) {
      xPl = codemod.getJSONObject(str(i)).getInt("arg1");
    } else if(codemod.getJSONObject(str(i)).getInt("command") == 4) {
      yPl = codemod.getJSONObject(str(i)).getInt("arg1");
    }
  }*/
  // loader script
  /*setupCodeFile = loadStrings("setupCode.txt");
  for(int i = 0; i < setupCodeFile.length; i++) {
    setupCode+=setupCodeFile[i];
  }
  print("\n-/"+setupCode+"\n");
  if(!errorCode) {
    try {
      icode.eval(setupCode);
      icode.set("getvar_scale",1.0);
      if((Boolean)icode.get("boolvar_scale")) {
        scale = (float)icode.get("var_scale");
      }
      if((Boolean)icode.get("boolvar_xPl")) {
        xPl = (int)icode.get("var_xPl");
      }
      if((Boolean)icode.get("boolvar_yPl")) {
        yPl = (int)icode.get("var_yPl");
      }
      print("setupCode end run");
    } catch(Exception e) {
      //System.out.printf("Caught exception %s doing something.%n", e.toString());
      e.printStackTrace();
      errorCode = true;
    }
  }*/
  saveBl.load_newsave();
  mod.setupScript();
}

void draw() {
  xFantomCamera=(int)moux/180;
  yFantomCamera=(int)mouy/180;
  if(xFantomCamera > 1) {
    xFantomCamera = 1;
  } else if(xFantomCamera < -1) {
    xFantomCamera = -1;
  }
  if(yFantomCamera > 1) {
    yFantomCamera = 1;
  } else if(yFantomCamera < -1) {
    yFantomCamera = -1;
  }
  mod.drawScript();
  // open var:
  // var_scale = scale
  // var_xPl = xPl
  /*if(!errorCode) {
    try {
      icode.eval("float var_scale = 1;");
      scale = (float)icode.get("var_scale");
    } catch(Exception e) {
      System.out.printf("Caught exception %s doing something.%n", e.toString());
      e.printStackTrace();
      errorCode = true;
    }
  }*/
  disW = width;
  disH = height;
  disH2 = disH/2;
  disW2 = disW/2;
  moux = mouseX-disW2;
  mouy = -mouseY+disH2;
  if(frameCount % 60 == 0 && disW != startw || disH != starth) {
    map = new int[round(width/size)+2][round(height/size)+2];
    map2 = new int[round(width/size)+4+2][round(height/size)+4+2];
    map3 = new int[round(width/size)+4+2][round(height/size)+4+2];
    map4 = new int[round(width/size)+2][round(height/size)+2];
    map5 = new int[round(width/(size*2))+2][round(height/(size*2))+2];
    startw = disW;
    starth = disH;
  }
  // Сохранение каждый 60 кадр
  if(frameCount % 60 == 0 && bl0.length != 0) {
    saveBl.save();
  }
  background(0);
  noStroke();
  if(event == 0) {
    xPos = xPl;
    yPos = yPl;
    icl++;
    cloudsX+=0.01;
    if(icl > frameSpeed) {
      frameCl+=0.0005;
      icl = 0;
    }
    i3++;
    if(i3 > atmoUpdateTick) {
      atmoX+=0.5;
      atmoInt=renderatmonoiseThread.renderatmonoise();
      i3 = 0;
    }
    i2++;
    if(i2 > updateNoiseMapTick) {
      rendernoiseThread.rendernoise();
      i2=0;
    }
    rendermapThread.draw();
    rendermap2Thread.draw();
    if(clouds) {
      rendercloudsThread.draw();
    }
    // color screen
    if(noisecenter(0,0) <= 100 && noisecenter4(0,0) > -30) {
      fill(40,40,220,60);
    } else {
      fill(0,0,0,0);
    }
    rect(0,0,disW,disH);
    if(atmoInt > 40) {
      fill(0,0,0,60);
    }
    rect(0,0,disW,disH);
    stroke(0);
    fill(255,255,255,60);
    setBlock(0-(xFantomCamera*size),0-(yFantomCamera*size),size,size);
    fill(255,255,255,140);
    setBlock(-disW2+100,-disH2+100,60,60);
    setBlock(-disW2+160,-disH2+100,60,60);
    setBlock(-disW2+220,-disH2+100,60,60);
    setBlock(-disW2+160,-disH2+160,60,60);
    setBlock(disW2-160,-disH2+100,60,60); // внизу
    setBlock(disW2-100,-disH2+160,60,60); // справа
    setBlock(disW2-220,-disH2+160,60,60); // слева
    setBlock(disW2-160,-disH2+220,60,60); // вверху
    setBlock(-disW2+80,disH2-80,70,70);
    if(mousePressed) {
      i++;
      /*if(noisecenter(0,0) <= 100 && noisecenter4(0,0) >= -30) {
        delframe = 5;
      } else if(noisecenter(0,0) <= 100 && noisecenter4(0,0) <= -30) {
        delframe = 12;
      } else if(noisecenter(0,0) >= 100 && noisecenter(0,0) <= 110 || noisecenter4(0,0) >= 40) {
        delframe = 8;
      } else if(noisecenter(0,0) >= 110) {
        delframe = 10;
      }*/
      if(noisecenter(0,0) <= 100) {
        if(noisecenter4(0,0) <= 50) {
          if(noisecenter4(0,0) <= -30) {
            delframe = 12;
          } else if(noisecenter4(0,0) >= -30) {
            delframe = 5;
          }
        }
      } else if(noisecenter(0,0) >= 100 && noisecenter(0,0) <= 110 && noisecenter4(0,0) >= -30) {
        delframe = 8;
      } else if(noisecenter(0,0) >= 100) {
        if(noisecenter4(0,0) <= -30) {
          delframe = 10;
        } else if(noisecenter4(0,0) >= -30 && noisecenter4(0,0) <= 40) {
          delframe = 10;
        } else if(noisecenter4(0,0) >= 40) {
          delframe = 8;
        }
      }
      if(i >= frameRate/delframe) {
        if(tap(-disW2+100,-disH2+100,60,60)) {
          xPl-=plspeed;
        } else if(tap(-disW2+160,-disH2+100,60,60)) {
          yPl-=plspeed;
        } else if(tap(-disW2+220,-disH2+100,60,60)) {
          xPl+=plspeed;
        } else if(tap(-disW2+160,-disH2+160,60,60)) {
          yPl+=plspeed;
        }
        i=0;
      }
    } else {
      i=0;
    }
  }
  fill(0);
  setText(str(setblockinvid),-disW2+80,disH2-80,40);
  fill(200);
  setText("xPos: "+xPos+" / yPos: "+yPos+"/ Seed: "+seed+" / i: "+i+" / delframe: "+delframe+"/ atmo: "+atmoInt+" / Scale: "+scale,0,-disH2+20,20);
  setText("v0.2 / Game By NoName24",0,-disH2+40,20);
  setText("cplx(): "+cplx()+" / cply: "+cply()+" / xFantomCamera: "+xFantomCamera+" / yFantomCamera: "+yFantomCamera,0,-disH2+60,20);
  fill(160,160,160,220);
  if(noisecenter(0,0) <= 100) {
    if(noisecenter4(0,0) <= 50) {
      if(noisecenter4(0,0) <= -30) {
        typeblockstr = "Лед";
      } else if(noisecenter4(0,0) >= -30) {
        typeblockstr = "Вода";
      }
    }
  } else if(noisecenter(0,0) >= 100 && noisecenter(0,0) <= 110 && noisecenter4(0,0) >= -30) {
    typeblockstr = "Берег";
  } else if(noisecenter(0,0) >= 100) {
    if(noisecenter4(0,0) <= -30) {
      typeblockstr = "Снежный биом (биом)";
    } else if(noisecenter4(0,0) >= -30 && noisecenter4(0,0) <= 40) {
      typeblockstr = "Равнина (биом)";
    } else if(noisecenter4(0,0) >= 40) {
      typeblockstr = "Пустыня (биом)";
    }
  } else {
    typeblockstr = "Неизвестно";
  }
  setText(typeblockstr,0,0,30);
  if(noisecenter2(0,0) == 0) {
    typeblockstr = "Пустота";
  } else if(noisecenter2(0,0) == 1) {
    typeblockstr = "Бревно";
  } else if(noisecenter2(0,0) == 2) {
    typeblockstr = "Листва";
  } else if(noisecenter2(0,0) == 3) {
    typeblockstr = "Кактус";
  }
  setText(typeblockstr,0,-30,30);
  setText("FPS: "+r(frameRate)+" / map1: "+noisecenter(0,0)+" / map4: "+(noisecenter4(0,0)-1),0,-60,30);
  //filter(POSTERIZE, 4);
  mod.drawUIScript();
}

void mouseReleased() {
  //zPos+=0.05;
  disW = width;
  disH = height;
  disH2 = disH/2;
  disW2 = disW/2;
  moux = mouseX-disW2;
  mouy = -mouseY+disH2;
  if(event == 0) {
    if(tap(-disW2+80,disH2-80,70,70)) {
      setblockinvid++;
      if(setblockinvid == inv.length) {
        setblockinvid = 0;
      }
    }
    // уничтожен��е / установка блоков
    if(tap(disW2-160,-disH2+100,60,60)) {
      if(noisecenter2(0,-1) != 0) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl);
        bl2 = append(bl2,yPl-1);
        bl3 = append(bl3,0);
      } else {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl);
        bl2 = append(bl2,yPl-1);
        bl3 = append(bl3,inv[setblockinvid][0]);
      }
    } else if(tap(disW2-100,-disH2+160,60,60)) {
      if(noisecenter2(1,0) != 0) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl+1);
        bl2 = append(bl2,yPl);
        bl3 = append(bl3,0);
      } else if(setblocktype == 1) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl+1);
        bl2 = append(bl2,yPl);
        bl3 = append(bl3,inv[setblockinvid][0]);
      }
    } else if(tap(disW2-220,-disH2+160,60,60)) {
      if(noisecenter2(-1,0) != 0) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl-1);
        bl2 = append(bl2,yPl);
        bl3 = append(bl3,0);
      } else if(setblocktype == 1) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl-1);
        bl2 = append(bl2,yPl);
        bl3 = append(bl3,inv[setblockinvid][0]);
      }
    } else if(tap(disW2-160,-disH2+220,60,60)) {
      if(noisecenter2(0,1) != 0) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl);
        bl2 = append(bl2,yPl+1);
        bl3 = append(bl3,0);
      } else if(setblocktype == 1) {
        bl0 = append(bl0,1);
        bl1 = append(bl1,xPl);
        bl2 = append(bl2,yPl+1);
        bl3 = append(bl3,inv[setblockinvid][0]);
      }
    }
  }
}

class rendernoiseThreadclass extends Thread {
  void rendernoise() {
    noiseSeed(seed);
    for (int x = 0; x != map.length-1; x++) {
      for (int y = 0; y != map[x].length-1; y++) {
        float noise = noise((x + xPos+1000000 + xFantomCamera) * scale, (y + yPos+1000000 + yFantomCamera) * scale, zPos);
        int h = round(map(noise, 0, 1, 0, 255));
        map[x][y] = h;
      }
    }
    noiseSeed(seed2);
    for(int x = 1; x < map2.length-4; x++) {
      for(int y = 1; y < map2[x].length-4; y++) {
        map2[x][y] = 0;
      }
    }
    noiseSeed(seed3);
    for (int x = 0; x != map.length; x++) {
      for (int y = 0; y != map[x].length; y++) {
        float noise = noise((x + xPos+100000 + xFantomCamera) * (scale*10), (y + yPos+100000 + yFantomCamera) * (scale*10), zPos);
        int h = round(map(noise, 0, 1, 0, 255));
        map3[x][y] = h;
      }
    }
    for(int x = 1; x < map2.length-4; x++) {
      for(int y = 1; y < map2[x].length-4; y++) {
        if(map4[x][y] < 35 && map[x][y] > 105 && map[x][y] > (map3[x][y]/1.25) && map[x][y] < (map3[x+1][y]/1.35)+4 && map2[x-1][y] == 0 && map2[x-1][y+1] == 0 && map2[x][y+1] == 0 && map2[x+1][y+1] == 0 && map2[x+1][y] == 0 && map2[x+1][y-1] == 0 && map2[x][y-1] == 0 && map2[x-1][y-1] == 0) {
          map2[x][y] = 1;
          map2[x][y+1] = 1;
          map2[x][y+2] = 1;
          map2[x-1][y+2] = 2;
          map2[x+1][y+2] = 2;
          map2[x][y+3] = 2;
        }
        if(map4[x][y] > 45 && map[x][y] > 100 && map[x][y] > (map3[x][y]/1.00) && map[x][y] < (map3[x+1][y]/1.20)+2 && map2[x-1][y] == 0 && map2[x][y-1] == 0 && map2[x+1][y] == 0 && map2[x][y+1] == 0 && map2[x-1][y-1] == 0 && map2[x+1][y-1] == 0 && map2[x-1][y+1] == 0 && map2[x+1][y+1] == 0) {
          map2[x][y+1] = 3;
          map2[x][y+2] = 3;
        }
      }
    }
    for(int i = 0; i < bl0.length; i++) {
      if(bl1[i] >= xPl-int(disW2/size) && bl2[i] >= yPl-int(disH2/size) && bl1[i] <= xPl+int(disW2/size) && bl2[i] <= yPl+int(disH2/size)) {
        if(bl0[i] == 1) {
          map2[cplx()+bl1[i]-xPl+1][cply()+bl2[i]-yPl+1] = bl3[i];
        }
      }
    }
    noiseSeed(seed4);
    for (int x = 0; x != map4.length; x++) {
      for (int y = 0; y != map4[x].length; y++) {
        float noise = noise((x + xPos+1000000 + xFantomCamera) * scale/3, (y + yPos+1000000 + yFantomCamera) * scale/3, zPos);
        int h = round(map(noise, 0, 1, -150, 150));
        map4[x][y] = h;
      }
    }
    noiseSeed(seed5);
    for (int x = 0; x != map5.length; x++) {
      for (int y = 0; y != map5[x].length; y++) {
        float noise = noise((x + xPos+1000000 + cloudsX + xFantomCamera) * scale*2, (y + yPos+1000000 + cloudsY + yFantomCamera) * scale*2, zPos+frameCl);
        int h = round(map(noise, 0, 1, -355+(atmoInt*3), 255));
        map5[x][y] = h;
      }
    }
    mod.rendernoiseThreadScript();
  }
}

class rendermapThreadclass extends Thread {
  void draw() {
    for(int x = 0; x < map.length-1; x++) {
      for(int y = 0; y < map[x].length-1; y++) {
        //print("x: "+x+" / y: "+y);
        if(map[x][y] <= 100) {
          if(map4[x][y] <= 50) {
            if(map4[x][y] <= -30) {
              fill(170+(map[x][y]/4),170+(map[x][y]/4),220+(map[x][y]/4));
            } else if(map4[x][y] >= -30) {
              fill(20,20,160+map[x][y]);
            }
          } else {
            //fill(220+(map[x][y]/4),220+(map[x][y]/4),50+(map[x][y]/2));
          }
        } else if(map[x][y] >= 100 && map[x][y] <= 110 && map4[x][y] >= -30) {
          fill(220+(map[x][y]/4),220+(map[x][y]/4),50+(map[x][y]/2));
        } else if(map[x][y] >= 100) {
          if(map4[x][y] <= -30) {
            fill(230+map[x][y]/10);
          } else if(map4[x][y] >= -30 && map4[x][y] <= 40) {
            fill(0,140+map[x][y]/5,0);
          } else if(map4[x][y] >= 40) {
            fill(220+(map[x][y]/4),220+(map[x][y]/4),size+(map[x][y]/2));
          }
        } else {
          fill(0);
        }
        setBlock(((x-(map.length/2))*size)+size,((y-(map[x].length/2))*size)+size,size,size);
      }
    }
    mod.rendermapThreadScript();
  }
}

class renderatmonoiseThreadclass extends Thread {
  int renderatmonoise() {
    noiseSeed(seed6);
    int atmomap[] = new int[1];
    for (int x = 0; x != atmomap.length; x++) {
      float noise = noise((x + atmoRand+atmoX) * scale/2);
      int h = round(map(noise, 0, 1, -50, 80));
      atmomap[x] = h;
    }
    mod.renderatmonoiseThreadScript();
    return atmomap[0];
  }
}

class rendermap2Threadclass extends Thread {
  void draw() {
    for(int x = 1; x < map2.length-4; x++) {
      for(int y = 1; y < map2[x].length-4; y++) {
        if(map2[x][y] == 1) {
          fill(200,20,20);
        } else if(map2[x][y] == 2) {
          if(map4[x][y] > -30) {
            fill(30,230,30,220);
          } else if(map4[x][y] < -30) {
            fill(255,255,255,235);
          }
        } else if(map2[x][y] == 3) {
          fill(40,230,40);
        } else {
          fill(0,0,0,0);
        }
        if(map2[x][y] != 0) {
          setBlock(((x-((map2.length-2)/2))*size)+size,((y-((map2[x].length-2)/2))*size)+size,size,size);
        }
      }
    }
    mod.rendermap2ThreadScript();
  }
}

class rendercloudsThreadclass extends Thread {
  void draw() {
    // clouds
    for(int x = 0; x < map5.length-1; x++) {
      for(int y = 0; y < map5[x].length-1; y++) {
        if(atmoInt > 40) {
          fill(200,200,200,map5[x][y]*3);
        } else {
          fill(255,255,255,map5[x][y]*3);
        }
        if(map5[x][y] > 5) {
          setBlock(((x-((map5.length)/2))*size*2)+size*2,((y-((map5[x].length)/2))*size*2)+size*2,size*2,size*2);
        }
      }
    }
    mod.rendercloudsThreadScript();
  }
}

class saveBl extends Thread {
  void load_newsave() {
    // Сохранение (bl0)
    try {
      // Загружает сохранение
      saveBljson = loadJSONObject("SaveWorldBl.txt");
      for (int count = 0; count < saveBljson.size(); count++) {
        JSONObject saveBljson2 = new JSONObject();
        saveBljson2 = saveBljson.getJSONObject(str(count));
        bl0 = append(bl0,saveBljson2.getInt("Bl0"));
        bl1 = append(bl1,saveBljson2.getInt("Bl1"));
        bl2 = append(bl2,saveBljson2.getInt("Bl2"));
        bl3 = append(bl3,saveBljson2.getInt("Bl3"));
      }
      // Если нет, то создает файл
    } catch(Exception e) {
      saveBljson = new JSONObject();
      for (int count = 0; count < bl0.length; count++) {
      JSONObject saveBljson2 = new JSONObject();
      saveBljson2.setInt("Bl0",bl0[count]);
      saveBljson2.setInt("Bl1",bl1[count]);
      saveBljson2.setInt("Bl2",bl2[count]);
      saveBljson2.setInt("Bl3",bl3[count]);
      saveBljson.setJSONObject(str(count),saveBljson2);
      }
      saveJSONObject(saveBljson,"SaveWorldBl.txt");
    }
    /*
    // Сохранение (bl1)
    try {
      // Загружает сохранение
      saveBl1 = loadJSONObject("SaveWorldBl1.txt");
      for (int count = 0; count < saveBl1.size(); count++) {
        bl1 = append(bl1,saveBl1.getInt(str(count)));
      }
      // Если нет, то создает файл
    } catch(Exception e) {
      saveBl1 = new JSONObject();
      for (int count = 0; count < bl1.length; count++) {
        saveBl1.setInt(str(count),bl1[count]);
      }
      saveJSONObject(saveBl1,"SaveWorldBl1.txt");
    }
    // Сохранение (bl2)
    try {
      // Загружает сохранение
      saveBl2 = loadJSONObject("SaveWorldBl2.txt");
      for (int count = 0; count < saveBl2.size(); count++) {
        bl2 = append(bl2,saveBl2.getInt(str(count)));
      }
      // Если нет, то создает файл
    } catch(Exception e) {
      saveBl2 = new JSONObject();
      for (int count = 0; count < bl2.length; count++) {
        saveBl2.setInt(str(count),bl2[count]);
      }
      saveJSONObject(saveBl2,"SaveWorldBl2.txt");
    }
    // Сохранение (bl3)
    try {
      // Загружает сохранение
      saveBl3 = loadJSONObject("SaveWorldBl3.txt");
      for (int count = 0; count < saveBl3.size(); count++) {
        bl3 = append(bl3,saveBl3.getInt(str(count)));
      }
      // Если нет, то создает файл
    } catch(Exception e) {
      saveBl3 = new JSONObject();
      for (int count = 0; count < bl3.length; count++) {
        saveBl3.setInt(str(count),bl3[count]);
      }
      saveJSONObject(saveBl3,"SaveWorldBl3.txt");
    }
    */
  }
  void save() {
    saveBljson = new JSONObject();
    for (int count = 0; count < bl0.length; count++) {
      JSONObject saveBljson2 = new JSONObject();
      saveBljson2.setInt("Bl0",bl0[count]);
      saveBljson2.setInt("Bl1",bl1[count]);
      saveBljson2.setInt("Bl2",bl2[count]);
      saveBljson2.setInt("Bl3",bl3[count]);
      saveBljson.setJSONObject(str(count),saveBljson2);
    }
    saveJSONObject(saveBljson,"SaveWorldBl.txt");
    /*
    saveJSONObject(saveBl0,"SaveWorldBl0.txt");
    saveBl1 = new JSONObject();
    for (int count = 0; count < bl1.length; count++) {
      saveBl1.setInt(str(count),bl1[count]);
    }
    saveJSONObject(saveBl1,"SaveWorldBl1.txt");
    saveBl2 = new JSONObject();
    for (int count = 0; count < bl2.length; count++) {
      saveBl2.setInt(str(count),bl2[count]);
    }
    saveJSONObject(saveBl2,"SaveWorldBl2.txt");
    saveBl3 = new JSONObject();
    for (int count = 0; count < bl3.length; count++) {
      saveBl3.setInt(str(count),bl3[count]);
    }
    */
  }
}
