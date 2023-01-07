#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

OUTDATED_FORMULAE=$(brew outdated)
echo $OUTDATED_FORMULAE
COUNT=$(echo $OUTDATED_FORMULAE | wc -w | tr -d ' ')
LIST="$(echo $OUTDATED_FORMULAE | xargs -L1)"

COUNTER=0
args+=(--remove '/brew.template\.*/')

COLOR=$RED

case "$COUNT" in
  [2-5][0-9]) COLOR=$RED
  ;;
  [1-0][0-9]) COLOR=$ORANGE
  ;;
  [1-9]) COLOR=$YELLOW
  ;;
  0) COLOR=$YELLOW
     COUNT=􀆅
  ;;
esac

sketchybar --set brew label=$COUNT icon.color=$COLOR

if [ "$LIST" = "" ];
then
  args+=(
  --add item brew.template.$COUNTER popup.brew \
    --set brew.template.$COUNTER icon="Packages:"  label="up to date" icon.color=$COLOR
      --set brew.template.$COUNTER drawing=on \
        background.corner_radius=12        \
        background.padding_left=12         \
        background.padding_right=12        \
        background.color=$ACCENT           \
        background.drawing=off
      )
else
  for word in $LIST; do
    args+=(
    --add item brew.template.$COUNTER popup.brew \
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
fi

sketchybar -m "${args[@]}"

