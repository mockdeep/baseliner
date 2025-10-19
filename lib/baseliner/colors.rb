module Baseliner::Colors
  def red(text)
    "\e[31m#{text}\e[0m"
  end

  def green(text)
    "\e[32m#{text}\e[0m"
  end

  def yellow(text)
    "\e[33m#{text}\e[0m"
  end

  def blue(text)
    "\e[34m#{text}\e[0m"
  end

  def magenta(text)
    "\e[35m#{text}\e[0m"
  end

  def cyan(text)
    "\e[36m#{text}\e[0m"
  end

  def light_red(text)
    "\e[91m#{text}\e[0m"
  end

  def light_magenta(text)
    "\e[95m#{text}\e[0m"
  end

  def color_percent(text)
    if text.to_f == 100.0
      green(text)
    elsif text.to_f >= 75.0
      yellow(text)
    else
      red(text)
    end
  end
end
