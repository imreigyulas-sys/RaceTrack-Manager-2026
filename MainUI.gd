extends Control

@onready var lbl_money = $VBoxContainer/LblMoney
@onready var lbl_stats = $VBoxContainer/LblStats
@onready var lbl_info = $VBoxContainer/LblInfo
@onready var game_manager = $GameManager

func _ready():
	update_ui()

func update_ui():
	lbl_money.text = "💰 Pénz: $" + str(game_manager.money) + " | Hírnév: " + str(game_manager.reputation)
	lbl_stats.text = "📅 Év: " + str(game_manager.current_year) + " | Verseny: " + str(game_manager.current_month) + "/12"

func _on_btn_race_pressed():
	var res = game_manager.run_race()
	lbl_info.text = res["text"]
	update_ui()

func _on_btn_upgrade_safety_pressed():
	if game_manager.money >= 40000:
		game_manager.money -= 40000
		game_manager.safety_level += 1
		lbl_info.text = "🛡️ Biztonság fejlesztve! Szint: " + str(game_manager.safety_level)
		update_ui()
	else:
		lbl_info.text = "❌ Nincs elég pénz a fejlesztéshez ($40,000)!"

func _on_btn_upgrade_stand_pressed():
	if game_manager.money >= 50000:
		game_manager.money -= 50000
		game_manager.grandstand_level += 1
		lbl_info.text = "🎟️ Lelátó bővítve! Szint: " + str(game_manager.grandstand_level)
		update_ui()
	else:
		lbl_info.text = "❌ Nincs elég pénz a lelátóhoz ($50,000)!"