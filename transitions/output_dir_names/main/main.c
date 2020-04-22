int main(int argc, char* argv[]) {
#ifdef NDEBUG
    return 1;
#else
    return 2;
#endif
}
