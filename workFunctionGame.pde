void updateSeeds() {
  seed2 = r(seed*2);
  seed3 = r(seed*3);
  seed4 = r(seed*4);
  seed5 = r(seed*5);
  seed6 = r(seed*6);
}

void updateSeed(int id) {
  if(id == 2) {
    seed2 = r(seed*2);
  } else if(id == 3) {
    seed3 = r(seed*3);
  } else if(id == 4) {
    seed4 = r(seed*4);
  } else if(id == 5) {
    seed5 = r(seed*5);
  } else if(id == 6) {
    seed6 = r(seed*6);
  } else {
    print("updateSeed: Unknown seed ID ("+id+")\n");
  }
}
