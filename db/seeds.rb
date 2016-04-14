store_name = "臣 亮 言 先 帝 創 業 未 半 而 中 道 崩 殂 今 天 下 三 分 益 州 疲 弊 此 誠 危 急 存 亡 之 秋 也".split
meal = "排骨 機腿 雞肉 牛肉 羊肉 豬肉".split
meal_2 = "飯 麵 粥 排".split
family_name = "趙 錢 孫 李 周 吳 鄭 王 馮 陳 褚 衛 蔣 沈 韓 楊".split

(1..5).to_a.each do |n|
  s = Store.new
  s.name = store_name.sample + store_name.sample + meal.sample + meal_2.sample
  s.phone = "0"
  s.address = store_name.sample + store_name.sample + "路157號"
  s.save
  s.opts.build(content: "貢丸", price: 10).save

  (1..5).to_a.each do |m|
    p = s.products.build
    p.title = store_name.sample + store_name.sample + meal.sample + meal_2.sample
    p.price = m * 10
    p.save
  end
end
