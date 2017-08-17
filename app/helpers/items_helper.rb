module ItemsHelper

  def deadline_date(date)
    if date.nil?
      ""
    elsif date.today?
      "Today"
    elsif (date - 1.day).today?
      "Tomorrow"
    elsif (date + 1.day).today?
      "Yesterday"
    elsif (date < Time.now + 7.days) && (date > Time.now)
      date.strftime("%A")
    elsif (date > Time.now - 7.days) && (date < Time.now)
      date.strftime("Last %A")
    elsif date.strftime("%Y") != Time.now.strftime("%Y")
      date.strftime("%b %-d, %Y")
    else
      date.strftime("%b %-d")
    end
  end

  def deadline_time(time)
    case time
    when nil
      ""
    else
      time.strftime("%-I:%M%p")
    end
  end

  def comma(date, time)
    if date && time
      ", "
    else
      ""
    end
  end
end
