class_name TimeData
extends Resource

export(int) var year := 0
export(Consts.SEASON) var season := Consts.SEASON.SUMMER
export(Consts.WEEKDAY) var weekday := Consts.WEEKDAY.MONDAY
export(int, 1, 28) var day := 1
export(int, 0, 23) var hour := 0
export(int, 0, 59) var minute := 0

var time_id := '' setget ,_get_time_id


# TODO precisa colocar internationalization in these methods
func get_weekday_min_str() -> String:
	var weekdays = [ 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN' ]
	return weekdays[weekday]


# TODO precisa colocar internationalization in these methods
func get_weekday_full_str() -> String:
	var weekdays = [ 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY' ]
	return weekdays[weekday]


# TODO precisa colocar internationalization in these methods
func get_season_min_str() -> String:
	var seasons = [ 'SUM', 'AUT', 'WIN', 'SPR' ]
	return seasons[season]


# TODO precisa colocar internationalization in these methods
func get_season_full_str() -> String:
	var seasons = [ 'SUMMER', 'AUTUMN', 'WINTER', 'SPRING' ]
	return seasons[season]


func is_equal_time_id(time_id_to_compare: String) -> bool:
	return _get_time_id() == time_id_to_compare


func _get_time_id() -> String:
	return '%03dy%ss%02dd%02dh%02dm' % [ year, Times.TIME_ID_SEASONS[season], day, hour, minute ]


func set_by_time_id(time_id: String):
	assert(_check_time_id_valid(time_id))
	year = time_id.substr(0, 3).to_int()
	season = Times.TIME_ID_SEASONS.find(time_id.substr(4, 3))
	day = time_id.substr(8, 2).to_int()
	hour = time_id.substr(11, 2).to_int()
	minute = time_id.substr(14, 2).to_int()
	weekday = (day - 1) % 7


func _check_time_id_valid(time_id: String) -> bool:
	if time_id.length() != 17:
		return false
	
	var year = time_id.substr(0, 3)
	var season = time_id.substr(4, 3)
	var day = time_id.substr(8, 2)
	var hour = time_id.substr(11, 2)
	var minute = time_id.substr(14, 2)
	
	return year.is_valid_integer() \
		&& (0 <= year.to_int() and year.to_int() <= 999) \
		&& time_id[3] == 'y' \
		&& Times.TIME_ID_SEASONS.has(season) \
		&& season.is_valid_identifier() \
		&& time_id[7] == 's' \
		&& day.is_valid_integer() \
		&& (1 <= day.to_int() and day.to_int() <= 28) \
		&& time_id[10] == 'd' \
		&& hour.is_valid_integer() \
		&& (0 <= hour.to_int() and hour.to_int() <= 23) \
		&& time_id[13] == 'h' \
		&& minute.is_valid_integer() \
		&& (0 <= minute.to_int() and minute.to_int() <= 59) \
		&& time_id[16] == 'm'
