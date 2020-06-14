require "google_drive"

# config.jsonを読み込んでセッションを確立
session = GoogleDrive::Session.from_config("config.json")

# # スプレッドシートをURLで取得
sp = session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/1Br_ZO96b93B4BeV2lVZuiTU1dh9sgNTj-zl32R-R-64/edit#gid=0")

# # "シート1"という名前のワークシートを取得
# ws = sp.worksheet_by_title("sheet1")

# # セルを指定して値を更新　インデックスの基準は1
# p ws[2, 1]
