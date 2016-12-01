class Gift
  def assign(current_user_famorg_id, season_id)
    people = User.joins(:famorgs).where('famorgs.id = ?', current_user_famorg_id).joins(:seasons).where('seasons.id = ?', season_id)
    santas = people.map { |a| a.id }
    people.each do |person|
      eligible = santas - [person.id]
      santaId = eligible.sample
      person.update_attributes(santa: santaId)
      santas.delete(santaId)
    end
  end
end
