#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

OUTDATED_FORMULAE=$(brew outdated)
echo $OUTDATED_FORMULAE
COUNT=$(echo $OUTDATED_FORMULAE | wc -w | tr -d ' ')
LIST="$(echo $OUTDATED_FORMULAE | xargs -L1)"

echo $LIST > $HOME/storage.txt

COUNTER=0
args+=(--remove '/brew.template\.*/')

COLOR=$RED

case "$COUNT" in
  [3-5][0-9]) COLOR=$RED
  ;;
  [1-2][0-9]) COLOR=$ORANGE
  ;;
  [1-9]) COLOR=$YELLOW
  ;;
  0) COLOR=$GREEN
     COUNT=􀆅
  ;;
esac

sketchybar --set brew label=$COUNT icon.color=$COLOR

for word in $LIST; do
  args+=(--add item brew.template.$COUNTER popup.brew \
    --set brew.template.$COUNTER icon=􀐛  label=$(basename $word) icon.color=$COLOR
    --set brew.template.$COUNTER drawing=on \
    background.corner_radius=12        \
    background.padding_left=12         \
    background.padding_right=12        \
    background.color=$ACCENT           \
    background.drawing=off
  )
  COUNTER=$((COUNTER + 1))
done

sketchybar -m "${args[@]}"

