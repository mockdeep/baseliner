# frozen_string_literal: true

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

  def color_number(number)
    if number.zero?
      green(number)
    elsif number <= 5
      yellow(number)
    else
      red(number)
    end
  end

  def color_percent(text)
    if Float(text.chomp("%")) == 100.0
      green(text)
    elsif Float(text.chomp("%")) >= 75.0
      yellow(text)
    else
      red(text)
    end
  end

  def center(text)
    padded_size = display_width + invisible_length(text)
    " #{text} ".center(padded_size, "=")
  end

  def spread(left_text, right_text)
    invisible_count = invisible_length(left_text) + invisible_length(right_text)
    padded_size = invisible_count + display_width - right_text.length

    "#{left_text.ljust(padded_size)}#{right_text}"
  end

  def invisible_length(text)
    text.scan(/\e\[\d+m/).join.length
  end

  def display_width
    60
  end
end
