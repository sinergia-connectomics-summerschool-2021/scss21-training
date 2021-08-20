# Sinergia Summer School 2021 Tutorials

You are in the gh-pages branch, which contains all sources for
producing [website](https://sinergia-connectomics-summerschool-2021.github.io/scss21-training/)
for the event. You can find main `README.md` in the [master branch](https://github.com/sinergia-connectomics-summerschool-2021/scss21-training/blob/master/README.md)
of the same repository.

## For instructors

If you want to contribute directly to this repository for your tutorial, please proceed as follows:

1. Clone the repository:

   ```
   git clone git@github.com:sinergia-connectomics-summerschool-2021/scss21-training.git
   ```

2. Checkout the `gh-pages` branch of this repository:  

   ```
   git checkout --track origin/gh-pages
   ```

3. Create a new `gh-pages-tutorial<id>` branch (with `<id>`, the number of your tutorial): 

   ```
   git checkout -b gh-pages-tutorial<id>
   ```

4. Make and commit your changes in the file of your tutorial that you can find inside the `_episodes` directory

5. To push your branch to this repository:
   
   ```
   git push origin gh-pages-tutorial<id>
   ```

6. Whenever your branch is ready, let me know

Below are some documentation for the development of a carpentries/repronim lesson.

### Resources

* [Carpentries Developer Documentation](https://carpentries.github.io/curriculum-development/technological-introductions.html)

* [Carpentries Lesson Example](https://carpentries.github.io/lesson-example/aio/index.html)

## Acknowledgment

Please see [LICENSE.md](LICENSE.md) for copyright, license, and how to acknowledge information.
