module EntriesHelper
  def formatted_copy_text(format, event, goal)
    text = format.presence || "今日のGood&Newは、\n{Good&New}\n\n目標は、\n{目標}"
    text.gsub('{Good&New}', event&.content.to_s)
        .gsub('{目標}', goal&.title.to_s)
  end
end
