BusinessTime::Config.load("#{Rails.root.join("config/business_time.yml")}")

BusinessTime::Config.beginning_of_workday = "00:00:00"
BusinessTime::Config.end_of_workday       = "23:59:59"
BusinessTime::Config.work_week            = [:mon, :tue, :wed, :thu, :fri]
