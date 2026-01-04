target="/media/prashant/PM Store/rsync_backup/prashant"

function backup() {
  echo $target/$1
  mkdir -p "$target/$1"
  rsync -av --recursive \
    --filter ". rsync_filter.txt" \
    --delete-excluded --delete --no-links \
    ~/$1 "$target/$1"
}

backup "Documents/"
backup "Downloads/"
backup ".local/share/applications/"
backup "Pictures/"
backup ".ssh/"
