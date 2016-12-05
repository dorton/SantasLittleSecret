class Gift
  def assign(famorg_id, season_id)
    people = User.joins(:famorgs).where('famorgs.id = ?', famorg_id).joins(:seasons).where('seasons.id = ?', season_id).shuffle
    santas = people.map { |a| a.id }
    the_shift = santas.shift
    santa_array = [*santas, *the_shift]
    i = 0
    people.each do |person|
      puts "#{person.id} --> #{santa_array[i]}"
      person.update_attributes(santa: santa_array[i])
      i +=1
    end
  end
end
