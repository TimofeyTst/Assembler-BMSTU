# Ubuntu configuration
```
    sudo apt install antlr4
```

> Далее необходимо установить нужную версию antlr4 из python
Проверьте текущую установленную версию:
```
    dpkg -s antlr4
```
На 20.05.2023 Ubuntu устанавливает 4.7.2
```
    pip install antlr4-python3-runtime==4.7.2
```

## Запуск программы
В корне проекта:
```
    cd lexer 
    antlr4 -Dlanguage=Python3 CPPFunction.g4
    python3 main.py test/first.txt
```
Или любой другой файл, в котором объявлена функция