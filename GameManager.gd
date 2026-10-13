extends Node

var track_name: String = "Apex Speedway"
var money: int = 350000
var reputation: int = 50

var current_year: int = 2026
var current_month: int = 1 # 1-től 12-ig
var season_scores: Array = []

var safety_level: int = 1
var grandstand_level: int = 1
var pitlane_level: int = 1
var asphalt_wear: float = 0.0

func run_race() -> Dictionary:
	if current_month > 12:
		return run_oscar_gala()

	asphalt_wear = clamp(asphalt_wear + 5.0, 0.0, 100.0)
	
	var driver_score = clamp(pitlane_level * 18.0 - (asphalt_wear * 0.3) + randf_range(-5, 5), 0, 100)
	var fan_score = clamp(grandstand_level * 20.0 + randf_range(-5, 5), 0, 100)
	var safety_score = safety_level * 20.0
	
	var weekend_avg = (driver_score + fan_score + safety_score) / 3.0
	season_scores.append(weekend_avg)
	
	var ticket_rev = int(grandstand_level * 10000 * (fan_score / 100.0))
	var total_income = ticket_rev + 15000 # Alap szponzor bevétel
	money += total_income
	
	var result_text = "Hétvége #" + str(current_month) + " kész!\n"
	result_text += "Bevétel: +$" + str(total_income) + "\n"
	result_text += "Pilóta: " + str(int(driver_score)) + "/100 | Néző: " + str(int(fan_score)) + "/100"
	
	current_month += 1
	return {"text": result_text, "finished": false}

func run_oscar_gala() -> Dictionary:
	var total = 0.0
	for sc in season_scores: total += sc
	var avg = total / season_scores.size() if season_scores.size() > 0 else 50.0
	
	var gala_text = "🏆 ÉV VÉGI GÁLA VÉGE!\nÉves átlag: " + str(int(avg)) + "/100\n"
	if avg >= 70:
		money += 80000
		reputation += 20
		gala_text += "🥇 Díjat nyertél: Az Év Pályája! (+$80,000)"
	else:
		gala_text += "Nem kaptál díjat idén."
		
	current_year += 1
	current_month = 1
	season_scores.clear()
	return {"text": gala_text, "finished": true}