# VIM editor
- vim.org
- sudo apt install vim
- create new file => vi filename.txt
- exit => :wq
- which vi
        /usr/bin/vi
- copy => cp /etc/ssh/sshd_config .
- different mode => x r i I  a A o O : :q! :w! :wq! shift+zz
- vimtutor
- shell cmd => :!
- search cmd => /keyword + Enter => n & N
- go to End of file => G or shift + g
- pattern search => ?keyword + enter => n & N
- /\<yes\> => * , #
- find and replace => %s/find-word/tobe-replaced-word/g
- undo above changes => e! + enter , u , ctrl + r
- cut a line => dd , paste => p
- cut 10 lines => 10dd , paste => p
- select multiple line => shift + V , paste => p
- set the numbers => :set nu 
- unset the numbers => :set nonu
- go to line # 100 => :100
- beginning of the file => gg
- copy paste content of one file to 2nd one => 
```
                ifconfig > a
                who -a > b
                cat a
                cat b
                vim a b
                - move from one file to next one
                :n
                :prev
```
- stcked windows => vi -o a b
- move bw files => ctrl + w
- to compare to files => vi -d a b or vidiff a b
- to print content from file linewise

```
sed -n 1p file
head -n 1 file
awk 'NR==1' file
```
        
