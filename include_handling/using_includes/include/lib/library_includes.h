#ifndef LIBRARY_INCLUDES_H
#define LIBRARY_INCLUDES_H

class LibraryIncludes
{
  public:
    LibraryIncludes();
    void ThisShouldTriggerAWarning()
    {
        int a{};
    };
};

#endif /* LIBRARY_INCLUDES_H */
