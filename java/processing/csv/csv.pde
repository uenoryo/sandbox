void setup(){
    background(255);
    size(800, 800);
    fill(0);

    String rows[] = loadStrings("business.csv");

    int max = 0;
    String name = "";

    for (int i = 0; i < rows.length; i++) {
        // 1行目はカラム名なので除外
        if (i == 0) {
            continue;
        }

        String cells[] = split(rows[i], ',');
        if (int(cells[3]) > max) {
            max = int(cells[3]);
            name = cells[2];
        }
    }

    text(name, 20, 20);
}

void draw() {
    //
}
