#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

void    perr(char *str)
{
    while (*str)
        write(2, str++, 1);
}

int cd(char **argv, int i)
{
    if (i != 2)
        return (perr("error: cd: bad arguments\n"), 1);
    else if (chdir(argv[1]) == -1)
        return (perr("error: cd: cannot change directory to "), perr(argv[1]), perr("\n"), 1);
    return 0;
}

int exec(char **argv, char **envp, int i)
{
    int status;
    int fds[2];
    int pip = (argv[i] && !strcmp(argv[i], "|"));

    if (pipe(fds) == -1)
        return (perr("error: fatal\n"), 1);
    int pid = fork();
    if (!pid)
    {
        argv[i] = 0;
        if (pip && (dup2(fds[1], 1) == -1 || close(fds[0]) || close(fds[1])))
            return (perr("error: fatal\n"), 1);
        execve(*argv, argv, envp);
        return (perr("error: cannot execute "), perr(*argv), perr("\n"), 1);
    }
    waitpid(pid, &status, 0);
    if (pip && (dup2(fds[0], 0) == -1 || close(fds[0]) || close(fds[1])))
        return (perr("error: fatal\n"), 1);
    return WIFEXITED(status) && WEXITSTATUS(status);
}

int main(int argc, char **argv, char **envp)
{
    (void)argc;
    int i = 0;
    int status = 0;

    while (*argv && *(argv + 1))
    {
        ++argv;
        i = 0;
        while (argv[i] && strcmp(argv[i], ";") && strcmp(argv[i], "|"))
            i++;
        if (!strcmp(*argv, "cd"))
            status = cd(argv, i);
        else if (i)
            status = exec(argv, envp, i);
        argv += i;
    }
    return status;
}

