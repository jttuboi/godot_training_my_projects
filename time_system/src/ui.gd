extends Control

var year_count := 0
var season_count := 0
var weekday_count := 0
var day_count := 0
var hour_count := 0
var minute_count := 0


func _ready():
	Signals.connect('year_changed', self, 'on_TimeSystem_year_changed')
	Signals.connect('season_changed', self, 'on_TimeSystem_season_changed')
	Signals.connect('weekday_changed', self, 'on_TimeSystem_weekday_changed')
	Signals.connect('day_changed', self, 'on_TimeSystem_day_changed')
	Signals.connect('hour_changed', self, 'on_TimeSystem_hour_changed')
	Signals.connect('minute_changed', self, 'on_TimeSystem_minute_changed')


func on_TimeSystem_year_changed(time_data: TimeData):
	year_count += 1
	$YearChanged.text = 'year changed called: %d' % [ year_count ]


func on_TimeSystem_season_changed(time_data: TimeData):
	season_count += 1
	$SeasonChanged.text = 'season changed called: %d' % [ season_count ]


func on_TimeSystem_weekday_changed(time_data: TimeData):
	weekday_count += 1
	$WeekdayChanged.text = 'weekday changed called: %d' % [ weekday_count ]


func on_TimeSystem_day_changed(time_data: TimeData):
	day_count += 1
	$DayChanged.text = 'day changed called: %d' % [ day_count ]


func on_TimeSystem_hour_changed(time_data: TimeData):
	hour_count += 1
	$HourChanged.text = 'hour changed called: %d' % [ hour_count ]


func on_TimeSystem_minute_changed(time_data: TimeData):
	$Clock.text = '%dy %s %s %sd %02d:%02d' % [ time_data.year, time_data.get_season_min_str(), time_data.get_weekday_min_str(), time_data.day, time_data.hour, time_data.minute ]
	minute_count += 1
	$MinuteChanged.text = 'minute changed called: %d' % [ minute_count ]


func _on_PauseButton_pressed():
	get_tree().paused = !get_tree().paused
