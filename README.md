Hi, here you will find my thoughts about [sddm](https://github.com/sddm/sddm "sddm").

_This is my playground, be aware of this!_

That are examples for my personal use and test.  
I share them, but you have to keep in mind, that software could eat your pet!

__To use it, you do it on your own risk!__

---

#### Now some Words to the themes:

- __openspace__ is originally made for [siduction](https://siduction.org "siduction homepage") with the name __deepspace__.  
  I renamed it to "openspace" to avoid name confusions.
  - openspace has the same background like sddm-theme-patience for siduction without the branding!
  - For technical reasons, we had to change some things there (sddm-themes for siduction), only the repository is named to __deepspace__, because of historical reasons.
 [sddm-theme-deepspace](https://github.com/siduction/sddm-theme-deepspace "the side on github").

 - _The themes for siduction have other release names!_

- __mammoth__ has just another background and i play more with the technik,  
  - the better choise is to use openspace!

- ##### Work with openspace:
 - You can change the background by your own. Take a look to theme.conf!
 - If you choose to use a light background search for
 
 ```qml
   /* background Main block */    
    /************************************************** 
     * openspace is made for dark backgrounds
     * if you have light ones, choose a background color
     * at the moment it is "transparent"
     * also take a look to the topBar above
     **************************************************/ 
    Rectangle {
        id: mainBlock
        anchors.centerIn: parent
        width: 534
        height: 150
        color:  "transparent" //"black" //"#053343"
        opacity: 0.25
        radius: 9
    }
    /* end background Main block */
```
 - be aware, the mainBlock is centered! (theme openspace) 
    - in mammoth the block is a bit deeper because of the pictures
    - remember, mammoth is my playground, it is hard to modify, because of my spagetti-code there.  
      But it works!
      
 - no $user pics are displayed and no $user-name is automaticly displayed in the user_entry field  
    - You want last succesfull logged in $user displayed? read the sources!
    - $user-pictures or avatars? no chance!
 
- all that fancy stuff is disabled!

_If nothing helps, fetch 
[sddm-theme-deepspace](https://github.com/siduction/sddm-theme-deepspace "the side on github")
and modify it to your needs.  
Or if you use [siduction](https://siduction.org "siduction homepage"), search for "sddm siduction" (`apt search sddm siduction`).  
For debian sid/unstable you are able to find them in the [siduction repositories](http://packages.siduction.org/ "packages.siduction.org/"), [amd64](http://packages.siduction.org/?Repositories:extra_amd64 "amd64") and [i386](http://packages.siduction.org/?Repositories:extra_i386 "i386").  
I told you, it is nearly the same, no fancy stuff and so on._

- __poetry__ is like openspace but, ... 
  - another background
  - no suspend and hibernate button
    - you can enable them verry easy, if you remove the comments  
     (take a look to the source (Main.qml) and read!)
  - date, time and hostname are displayed now top center
  - the fotmat for displaying the date and time is a bit different 
    - read the source, you will see and find a way to change it, if you want
    
- __humming__ it is based on poetry with some changes
  - i made it for to use with my LXQT installation and i wanna share it, have fun with it!
  - the hummingbird picture/ logo is taken from https://github.com/Caig/LXQt-graphics and carefully modified

- __2001__ just another space theme
  - now it is possible to show/ hide the password
    - if you want to disable that feature, look into the Main.qml file
   - as a workaround for 
        - https://github.com/sddm/sddm/issues/1199
        - and
        - https://bugs.kde.org/show_bug.cgi?id=412252
        
        _(I know it doesn't fix the issues)_
        - I added a timer for to reset the user_entry and the pw_entry
        - ~~and an onPressed and onReleased function for the show/hidePasswordPrompt_button~~
        - (if you want that pressed and released feature, read the Main.qml file)
        
    - the icons now are *.svg, qt can handle it
    - have fun with it
    - and no, no last successfully logged-in $user will be displayed
      - read above how to enable it
---

#### What is needed:

- [sddm](https://github.com/sddm/sddm "sddm")
- QtQuick 2.0 (normaly it should be automagicly installed together with sddm)
- QtGraphicalEffects 1.4 (qml-module-qtgraphicaleffects)

---

#### How to test the greeter?

- You modified the greeter and wanna test it?
- You only want to see how it looks like?

No problem,

```bsah
user@home:~$ sddm-greeter --test-mode --theme ~/download/path/to/the/sddm/greeter/theme/
```
---

#### How to install?

 Copy the theme folder to /usr/share/sddm/themes/
 
 Don't forget to edit in /etc/sddm.conf

 ```
 [Theme]
 # Current theme name
 Current=<your choise>  
```
In kf5/plasma you can use the sddm-kcm module ( kde-config-sddm) to choose via systemsettings the sddm-theme of your wishes.

 For debian/unstable aka sid I have made for the sddm-theme-2001 a debian package!
 
 You can download it from [here](https://github.com/hhl/sddm-theme-hhl/raw/master/debian-unstable/sddm-theme-2001/sddm-theme-2001_1.0_all.deb "download 2001")
 
 The other themes will follow, but it needs its time!
 
---
 
#### How it looks like?

##### openspace
![alt openspace-preview](https://github.com/hhl/sddm-theme-hhl/blob/master/openspace/images/preview.jpg "sddm-theme-openspace preview")

##### mammoth
![alt mammoth-preview](https://github.com/hhl/sddm-theme-hhl/blob/master/mammoth/images/preview.jpg "sddm-theme-mammoth preview")

##### poetry
![alt poetry-preview](https://github.com/hhl/sddm-theme-hhl/blob/master/poetry/images/preview.jpg "sddm-theme-poetry preview")

#### humming
![alt humming-preview](https://github.com/hhl/sddm-theme-hhl/blob/master/humming/images/preview.jpg "sddm-theme-humming preview")

#### icebear meets penguin
![alt icebear-preview](https://github.com/hhl/sddm-theme-hhl/blob/master/icebear/images/preview.jpg "sddm-theme-icebear preview")

#### 2001
![alt 2001-preview](https://github.com/hhl/sddm-theme-hhl/blob/master/2001/images/preview.jpg "sddm-theme-2001 preview")

---

##### Last but not least
 
_I try to keep them up to date, but i can't give any guarantee that it will be just in time!_
