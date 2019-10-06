#include <gtest/gtest.h>
#include <string>
#include <fstream>
#include <cstdlib>
#include <Poco/Process.h>
#include <Poco/Pipe.h>
#include <Poco/PipeStream.h>
#include <Poco/StreamCopier.h>
#include <vector>

using namespace std;

class LexerTests : public ::testing::Test {
public:
    LexerTests() {}
    ~LexerTests() {}
    void SetUp() {}
    void TearDown() {}
};

TEST_F(LexerTests, lexer)
{
    fstream all_tokens("all_tokens", ios::in);
    string to_write;
    Poco::Process::Args args;
    Poco::Pipe pin, pout, perr;
    Poco::ProcessHandle p = Poco::Process::launch("../lexer", args, &pin, &pout, NULL);
    Poco::PipeOutputStream ostr(pin);
    Poco::PipeInputStream istr(pout);
    while (getline(all_tokens, to_write))
    {
        ostr << to_write << endl;
    }
    ostr.close();
    fstream fout("Lexer_out", ios::out);
    Poco::StreamCopier::copyStream(istr, fout);
    fout.close();
    Poco::Pipe pipeout;
    vector<string> vargs;
    vargs.push_back("filecmp.py");
    vargs.push_back("Lexer_out");
    vargs.push_back("out_expected");
    p = Poco::Process::launch("python2", vargs, NULL, &pipeout, NULL);
    Poco::PipeInputStream outstr(pipeout);
    stringstream ss;
    Poco::StreamCopier::copyStream(outstr, ss);
    GTEST_ASSERT_EQ(ss.str(), "");
}

