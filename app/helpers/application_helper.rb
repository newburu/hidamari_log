module ApplicationHelper
  def default_meta_tags
    {
      site: "ひだまりろぐ",
      title: "日々の「よかったこと」や目標を記録するカレンダー",
      reverse: true,
      charset: "utf-8",
      description: "日々の「よかったこと(Good & New)」や目標を記録して、毎日を少し豊かにしませんか？あなただけのカレンダーで、成長を可視化しましょう。",
      keywords: "日記, 目標設定, Good & New, カレンダー, 自己成長",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp_image.png"),
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@newburu",
        image: image_url("ogp_image.png")
      }
    }
  end
end
