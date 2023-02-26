# Clipboard Sketchybar Widget

This is an implementation of a sketchybar clipboard to have a clickable sketcyhbar clipboard in the statusbar for
MacOS.

### Sketchybar script to render the clipboard

This is a script to render the python implementted clipboard for MacOS. It uses the `sketchybar` application
to render a status bar.

```bash { tangle: ./items/clipboard.sh }
#!/usr/bin/env sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item clipboard right                        \
           --set clipboard script="python3 $PLUGIN_DIR/clipboard.py" \
                      updates=on                             \
                      update_freq=30                    \
                      icon=                              \
                      background.padding_right=15            \
                      click_script="python3 $PLUGIN_DIR/clipboard.py && $POPUP_CLICK_SCRIPT" \
                      icon.font="$FONT:Regular:18.0"       \
           --add item clipboard.template left popup.clipboard \
```

### Python module implementation

We require some modules to use for our plugin, we are using the json and the subprocess modules to store information
and allow access to terminal commands so we can call `sketchybar`.

```python { tangle: ./plugins/clipboard.py }
#!python3
import json
import subprocess
```

The clipboard class is the main class for our application, it will store our data in memory and write to disk, so we
can perform operations on our data.

In this example we have a JSON object `Clipboard.storage`, that is responsable for getting our data from the `JSON` file
that is located on the device storage.

```python { tangle: ./plugins/clipboard.py }
class Clipboard:
    def __init__(self, file: str) -> None:
        self.file = file
        try: 
            with open(self.file, 'r') as openfile:
                json_object = json.load(openfile)
        except: 
            json_object = { "clipboard": [] }
        self.storage = json_object
```

We can write to the file by using `json.dumps`:

```python { tangle: ./plugins/clipboard.py }
    def write_to_clipboard(self) -> None:
        json_object = json.dumps(self.storage, indent=4)
        with open(self.file, "w") as outfile:
            outfile.write(json_object)
```

To add data to the clipboard, we can append the clipboard in storage.
We must encode the data from the paste buffer (`pbpaste`), and convert
it from `utf-8` to get our output data.

We can then add it to the clipboard, but as we are only storing the five
most recent items, we will pop the first item and remove it from our queue,
and append the next item to the clipboard.

```python { tangle: ./plugins/clipboard.py }
    def add_to_clipboard(self) -> bool:
        clip = subprocess.check_output("pbpaste").decode('utf-8').strip()
        if clip not in self.storage["clipboard"]:
            if len(self.storage["clipboard"]) < 5:
                self.storage["clipboard"].append(clip)
            else:
                self.storage["clipboard"].pop(0)
                self.storage["clipboard"].append(clip)
            return True
        return False
```

**Drawing our clipboard using Sketchybar**

To render the clipboard in our status bar, we will use `sketchybar` commandline
utility in order to push our data into the status bar, using some pre-established
formatting (see ![Sketchybar](https://github.com/FelixKratz/SketchyBar)) for more
information.

To draw our clipboard, we will pipe in the releavant data from our `JSON` clipboard
that has been preserved in memory (via the `Clipboard` class). This data is then rendered
by ![Sketchybar](https://github.com/FelixKratz/SketchyBar).

```python { tangle: ./plugins/clipboard.py }
    def draw_clipboard(self) -> None:
        options: list[str] = []
        if len(self.storage["clipboard"]) == 0:
            options += [
                'sketchybar',
                '-m',
                "--remove", 
                '/clipboard.template.[0-5]/',
                '--add',
                'item',
                f'clipboard.template.0', 
                'popup.clipboard',
                '--set',
                f'clipboard.template.0',
                'icon="Clipboard: "',
                'label="nothing has been copied"'
            ]
            subprocess.call(options)
        for clip in range(0, len(self.storage["clipboard"])):
            options += [
                'sketchybar',
                '-m',
                "--remove", 
                '/clipboard.template.[0-5]/',
                '--add',
                'item',
                f'clipboard.template.{clip}', 
                'popup.clipboard',
                '--set',
                f'clipboard.template.{clip}',
                'icon=◆',
                'icon.font="JetBrains Mono:Regular:14.0"',
                f'label={self.storage["clipboard"][clip]}',
                '--set',
                f'clipboard.template.{clip}',
                 f"""click_script=`echo '{self.storage["clipboard"][clip]}' | pbcopy` """
                'drawing=on',
                'label.width=120',
                'background.corner_radius=12',
                'background.padding_left=12',
                'background.padding_right=12',
                'background.drawing=off'
            ]
            try:
                subprocess.call(options)
            except subprocess.CalledProcessError as e:
                print ("write_to_clipboard.ERROR: ", e.output)
```

Lastly we need to establish our mainloop which checks if the clipboard has been updated
when calling the `add_to_clipboard`, this is polled by `Sketchybar` on a delay to see when
the clipboard was last updated.

If there is a change to the clipboard, we will re-draw it and write our new data to the clipboard.

NOTE: this implementation contains a full path referencing the user's account. This should be changed
depending on the expected file location of the clipboard in device storage.

```python { tangle: ./plugins/clipboard.py }
if __name__ == "__main__":
    clipboard = Clipboard("/Users/jordanp/.config/.clipboard_storage.json")
    if clipboardHasChanged := clipboard.add_to_clipboard():
        clipboard.write_to_clipboard()
        clipboard.draw_clipboard()
```
