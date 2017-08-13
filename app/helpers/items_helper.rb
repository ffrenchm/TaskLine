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
    elsif date - 7.days < Time.now
      date.strftime("%A")
    else
      date.strftime("%b %d")
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

#   def deadline(date, time)
#     deadline_date = Proc.new {
#       case date
#       when nil
#         return ""
#       else
#         return date.strftime("%b %d")
#       end
#     }
#     deadline_time = Proc.new {
#       case time
#       when nil
#         return ""
#       else
#         return time.strftime("%-I:%M%p")
#       end
#     }
#     comma = Proc.new {
#       if date && time
#         return ", "
#       else
#         return ""
#       end
#     }
#     return comma.call, deadline_time.call
#   end
end
