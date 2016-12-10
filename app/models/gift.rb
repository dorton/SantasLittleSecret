class Gift
  def assign(famorg_id, season_id)
    people = Famorg.find(famorg_id).users.shuffle
    santas = people.map { |a| a.id }
    the_shift = santas.shift
    santa_array = [*santas, *the_shift]
    i = 0
    people.each do |person|
      group_assign = UserFamorg.find_by(user_id: person.id, famorg_id: famorg_id)
      puts "#{person.id} --> #{santa_array[i]}"
      group_assign.update_attributes(santa_id: santa_array[i])
      i +=1
    end
  end
end
