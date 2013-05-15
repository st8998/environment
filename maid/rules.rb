Maid.rules do
  rule 'Downloaded ISO files' do
    dir('~/Downloads/*.iso').each do |path|
      if 1.day.since?(accessed_at(path))
        move(path, '~/Distr/')
      end
    end
  end

  rule 'Mac OS X applications in disk images' do
    dir('~/Downloads/*.dmg').each do |path|
      trash(path) if 1.day.since?(accessed_at(path))
    end
  end

  DEV_MATCH = Regexp.new %w[
    localhost
    cloudlogistics
    aeroflex
    staging
    pivotaltracker
  ].join('|')

  rule 'Files downloaded while developing/testing' do
    dir('~/Downloads/*').each do |path|
      if downloaded_from(path).any? { |u| u =~ DEV_MATCH } && 1.day.since?(accessed_at(path))
        trash(path)
      end
    end
  end

  rule 'Torrent files' do
    dir('~/Downloads/*.torrent').each do |path|
      trash(path) if 1.day.since?(accessed_at(path))
    end
  end

  rule 'Really old downloads' do
    dir('~/Downloads/*').each do |path|
      trash(path) if 2.days.since?(accessed_at(path))
    end
  end
end
