
meta =
{
    id = "HireMyCrew",
    name = "HireMyCrew",
    title = "Hire My Crew",

    type = "mod",
    description = "New Order for your AI-Capatained Ships to seek out and hire professional Crew for your Ship or Station.",
    authors = {"Shrooblord"},

    version = "0.1.0",

    dependencies = {
        {id = "Avorion", min = "1.0", max = "1.0.*"},

        --[[Shrooblord]]
        --{id = "1847767864", min = "1.1.4"},                 --ShrooblordMothership (library mod)
        {id = "ShrooblordMothership", min = "1.1.4"},     --ShrooblordMothership (library mod)
    },

    serverSideOnly = false,
    clientSideOnly = false,
    saveGameAltering = false,
    contact = "avorion@shrooblord.com",
}
